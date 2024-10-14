# Wasm
docker buildx build --platform wasm --tag sangeetakakati/sort-rust-wasm:wasm --output "type=image,push=true" --builder default .

docker buildx build --platform wasm --tag sangeetakakati/sort-tinygo-wasm:wasm --output "type=image,push=true" --builder default .

docker buildx build --platform wasm --tag sangeetakakati/cpp-sort-wasm:wasm --output "type=image,push=true" --builder default .

docker run --runtime=io.containerd.wasmtime.v1 --platform=wasm --rm --mount type=bind,source="$(pwd)",target=/app sangeetakakati/sort-rust-wasm:wasm

docker run --runtime=io.containerd.wasmtime.v1 --platform=wasm --rm --mount type=bind,source="$(pwd)",target=/app sangeetakakati/sort-tinygo-wasm:wasm

docker run --runtime=io.containerd.wasmtime.v1 --platform=wasm --rm --mount type=bind,source="$(pwd)",target=/app sangeetakakati/cpp-sort-wasm:wasm

# Native

docker buildx build --platform linux/amd64,linux/arm64 --tag sangeetakakati/sort-tinygo-native:latest --output "type=image,push=true" --builder default .

docker buildx build --platform linux/amd64,linux/arm64 --tag sangeetakakati/sort-rust-native:latest --output "type=image,push=true" --builder default .

docker buildx build --platform linux/amd64,linux/arm64 --tag sangeetakakati/cpp-sort-native:latest --output "type=image,push=true" --builder default .

docker run  --rm sangeetakakati/sort-rust-native:latest

docker run --rm sangeetakakati/sort-rust-native:latest

docker run --rm sangeetakakati/cpp-sort-native:latest


