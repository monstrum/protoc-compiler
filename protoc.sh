#!/bin/bash

read -r -d '' CMD <<- EOM
  protoc --go_out=plugins=grpc:./server \
      --plugin=protoc-gen-ts=/usr/bin/protoc-gen-ts \
      --ts_out=service=grpc-web:./client/typescript \
      --js_out=import_style=commonjs,binary:./client/commonjs \
      $(find "$@" -iname "*.proto")
EOM

mkdir -p server \
  client \
  client/commonjs \
  client/typescript

$($CMD)
