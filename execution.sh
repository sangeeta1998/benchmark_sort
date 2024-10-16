#!/bin/bash

# Function to detect system architecture
detect_architecture() {
    local arch=$(uname -m)
    case $arch in
        x86_64)
            echo "amd64"
            ;;
        aarch64)
            echo "arm64"
            ;;
        *)
            echo "Unsupported architecture: $arch"
            exit 1
            ;;
    esac
}

measure_execution_time() {
    image=$1
    runtime=$2
    platform=$3
    container_name="test_container"

    echo -e "\n============================================"
    echo "Running $image with $runtime"
    echo "--------------------------------------------"

    # Remove the image to ensure cold start
    docker rmi $image

    # Measure execution time
    {
        if [ -z "$runtime" ]; then
            # For native containers
            time docker run --name $container_name --rm --mount type=bind,source="$(pwd)",target=/app $image
        else
            # For Wasm containers with specific runtime
            time docker run --runtime=$runtime --platform=$platform --name $container_name --rm --mount type=bind,source="$(pwd)",target=/app $image
        fi
    } 2>&1 | tee -a execution_time.log

    echo -e "--------------------------------------------"
    echo "Execution for $image completed"
}

arch=$(detect_architecture)

rust_native_image="sangeetakakati/sort-rust-native:latest"
tinygo_native_image="sangeetakakati/sort-tinygo-native:latest"
cpp_native_image="sangeetakakati/cpp-sort-native:latest"
cpp_wasm_image="sangeetakakati/cpp-sort-wasm:wasm"
rust_wasm_image="sangeetakakati/sort-rust-wasm:wasm"
tinygo_wasm_image="sangeetakakati/sort-tinygo-wasm:wasm"

measure_execution_time "$rust_native_image" "" "$arch"
measure_execution_time "$rust_wasm_image" "io.containerd.wasmtime.v2" "wasm"

measure_execution_time "$tinygo_native_image" "" "$arch"
measure_execution_time "$tinygo_wasm_image" "io.containerd.wasmtime.v2" "wasm"

measure_execution_time "$cpp_native_image" "" "$arch"
measure_execution_time "$cpp_wasm_image" "io.containerd.wasmtime.v2" "wasm"

