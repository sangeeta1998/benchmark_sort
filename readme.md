# Wasm
docker buildx build --platform wasm --tag sangeetakakati/sort-rust-wasm:wasm --output "type=image,push=true" --builder default .

docker run --runtime=io.containerd.wasmtime.v2 --platform=wasm sangeetakakati/sort-rust-wasm:wasm

docker buildx build --platform wasm --tag sangeetakakati/sort-tinygo-wasm:wasm --output "type=image,push=true" --builder default .

docker run --runtime=io.containerd.wasmtime.v2 --platform=wasm --rm sangeetakakati/sort-tinygo-wasm:wasm

# Native

docker buildx build --platform linux/amd64,linux/arm64 --tag sangeetakakati/sort-tinygo-native:latest --output "type=image,push=true" --builder default .

docker run --platform=linux/amd64 --rm sangeetakakati/sort-tinygo-native:latest
docker run --platform=linux/arm64 --rm sangeetakakati/sort-tinygo-native:latest


docker buildx build --platform linux/amd64,linux/arm64 --tag sangeetakakati/sort-rust-native:latest --output "type=image,push=true" --builder default .

docker run --platform=linux/amd64 --rm sangeetakakati/sort-rust-native:latest
docker run --platform=linux/arm64 --rm sangeetakakati/sort-rust-native:latest

# Output files 

docker run --platform=linux/amd64 --rm -v "$(pwd)":/app sangeetakakati/sort-rust-native:latest
