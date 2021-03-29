# protobuf-compiler

This Dockerfile build a protoc compiler image for golang as server, commonjs and typescript as client.

## build
Change the `${docker-repo/image-name}` with your own docker hub repo.
```shell script
docker build -t ${docker-repo/image-name} .
```

## usage
If the proto files within current directory
```shell script
docker run --rm -it -v $PWD/proto:/code/proto ${docker-repo/image-name}
```

## Example using this image
```shell script
cd server/proto
protoc-go-inject-tag -input=./taxonomy.pb.go
```

# Example for `monstrum/protobuf-compiler`
```shell script
# Build
docker build -t monstrum/protobuf-compiler .

# Usage
docker run --rm -it -v $PWD/proto:/code/proto -v $PWD/server:/code/server -v $PWD/client:/code/client monstrum/protobuf-compiler

# Or bash into the container
docker run --rm -it -v $PWD/proto:/code/proto -v $PWD/server:/code/server -v $PWD/client:/code/client --entrypoint bash monstrum/protobuf-compiler
```

# Testing script `protoc.sh`
```shell script
# Or bash into the container
docker run --rm -it -v $PWD/protoc.sh:/code/protoc.sh -v $PWD/proto:/code/proto -v $PWD/server:/code/server -v $PWD/client:/code/client --entrypoint bash monstrum/protobuf-compiler

./protoc.sh ./proto
```
