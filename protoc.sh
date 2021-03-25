#!/bin/bash

SERVER_TARGET="./server"
CLIENT_TARGET="./client"
PHP_CLIENT_TARGET="$CLIENT_TARGET/php"
TYPESCRIPT_CLIENT_TARGET="$CLIENT_TARGET/typescript"

read -r -d '' CMD <<- EOM
  protoc --go_out=plugins=grpc:$SERVER_TARGET \
      --plugin=protoc-gen-ts=/usr/bin/protoc-gen-ts \
      --ts_out=service=grpc-web:$TYPESCRIPT_CLIENT_TARGET \
      --js_out=import_style=commonjs,binary:$TYPESCRIPT_CLIENT_TARGET \
      $(find "$@" -iname "*.proto")
EOM

INJECT_CMD="protoc-go-inject-tag "
GO_GENERATED_FILES=$(find "$SERVER_TARGET/proto" -iname "*.pb.go")

for GO_FILE_PATH in $GO_GENERATED_FILES
do
  INJECT_CMD="$INJECT_CMD -input=$GO_FILE_PATH"
done

mkdir -p "$SERVER_TARGET" \
  "$CLIENT_TARGET" \
  "$TYPESCRIPT_CLIENT_TARGET" \
  "$PHP_CLIENT_TARGET"

# Generate protoc server & clients
$($CMD)

# Inject tags to generated go files
$($INJECT_CMD)