#!/bin/bash

SERVER_TARGET="./server"
CLIENT_TARGET="./client"
PHP_CLIENT_TARGET="$CLIENT_TARGET/php"
TYPESCRIPT_CLIENT_TARGET="$CLIENT_TARGET/typescript"

read -r -d '' CMD <<- EOM
  protoc \
      --proto_path=. \
      --go_out=plugins=grpc:$SERVER_TARGET \
      --plugin=protoc-gen-ts=/usr/bin/protoc-gen-ts \
      --plugin=protoc-gen-grpc=/usr/bin/grpc_php_plugin \
      --grpc_out=$PHP_CLIENT_TARGET \
      --php_out=$PHP_CLIENT_TARGET \
      --ts_out=service=grpc-web:$TYPESCRIPT_CLIENT_TARGET \
      --js_out=import_style=commonjs,binary:$TYPESCRIPT_CLIENT_TARGET \
      $(find "$@" -iname "*.proto")
EOM

mkdir -p "$SERVER_TARGET" \
  "$CLIENT_TARGET" \
  "$TYPESCRIPT_CLIENT_TARGET" \
  "$PHP_CLIENT_TARGET"

# Generate protoc server & clients
echo "Generating protoc server & clients"
$($CMD)
echo "Protoc server & clients generated"

echo "Sleep 5s ..."
sleep 10

GO_GENERATED_FILES=$(find "$SERVER_TARGET/proto" -iname "*.pb.go")
# Inject tags to generated go files
echo "Inject tags to generated go files"
for GO_FILE_PATH in $GO_GENERATED_FILES
do
  INJECT_CMD="protoc-go-inject-tag -input=$GO_FILE_PATH"
  $($INJECT_CMD)
done
echo "Tags injected"