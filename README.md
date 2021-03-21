# protoc-compiler

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
docker run --rm -it -v $PWD/proto:/code/proto -v $PWD/test:/code/server -v $PWD/test-client:/code/client monstrum/protobuf-compiler
```

##Example using this image
```shell script
docker run --rm -it -v $PWD/proto:/code/proto monstrum/protoc-compiler
```
