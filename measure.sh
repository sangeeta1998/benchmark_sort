#!/bin/bash
# using docker

# detect the host architecture
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

measure_native_rust() {
    local arch=$1
    trials=10

    echo "Measuring Native Rust for $arch..."

    total_pull_time=0

    for i in $(seq 1 $trials); do
        # Cold start time from pull
        docker rmi sangeetakakati/sort-rust-native:latest > /dev/null 2>&1
        script_start_time=$(date +%s%3N)
        echo "Script start time: ${script_start_time} ms"
        main_start_time=$(docker run --platform=linux/$arch --rm sangeetakakati/sort-rust-native:latest 2>&1 | grep "Main function started at:" | awk '{print $5}')
        pull_time=$((main_start_time - script_start_time))
        total_pull_time=$((total_pull_time + pull_time))
        echo "Rust Sort Trial $i (Pull, $arch): Startup Time = $pull_time ms"
    done

    echo "Average Rust cold start time from pull ($arch): $((total_pull_time / trials)) ms"
}

measure_native_tinygo() {
    local arch=$1
    trials=10

    echo "Measuring Native TinyGo for $arch..."

    total_pull_time=0

    for i in $(seq 1 $trials); do
        # Cold start time from pull
        docker rmi sangeetakakati/sort-tinygo-native:latest > /dev/null 2>&1
        script_start_time=$(date +%s%3N)
        echo "Script start time: ${script_start_time} ms"
        main_start_time=$(docker run --platform=linux/$arch --rm sangeetakakati/sort-tinygo-native:latest 2>&1 | grep "Main function started at:" | awk '{print $5}')
        pull_time=$((main_start_time - script_start_time))
        total_pull_time=$((total_pull_time + pull_time))
        echo "TinyGo Sort Trial $i (Pull, $arch): Startup Time = $pull_time ms"
    done

    echo "Average TinyGo cold start time from pull ($arch): $((total_pull_time / trials)) ms"
}

measure_native_cpp() {
    local arch=$1
    trials=10

    echo "Measuring Native C++ for $arch..."

    total_pull_time=0

    for i in $(seq 1 $trials); do
        # Cold start time from pull
        docker rmi sangeetakakati/cpp-sort-native:latest > /dev/null 2>&1
        script_start_time=$(date +%s%3N)
        echo "Script start time: ${script_start_time} ms"
        main_start_time=$(docker run --platform=linux/$arch --rm sangeetakakati/cpp-sort-native:latest 2>&1 | grep "Main function started at:" | awk '{print $5}')
        pull_time=$((main_start_time - script_start_time))
        total_pull_time=$((total_pull_time + pull_time))
        echo "C++ Sort Trial $i (Pull, $arch): Startup Time = $pull_time ms"
    done

    echo "Average C++ cold start time from pull ($arch): $((total_pull_time / trials)) ms"
}

measure_wasm_rust() {
    trials=10
    architectures=("wasm")

    echo "Measuring Wasm Rust..."

    for arch in "${architectures[@]}"; do
        echo "Architecture: $arch"
        total_pull_time=0

        for i in $(seq 1 $trials); do
            # Cold start time from pull
            docker rmi sangeetakakati/sort-rust-wasm:wasm > /dev/null 2>&1
            script_start_time=$(date +%s%3N)
            echo "Script start time: ${script_start_time} ms"
            main_start_time=$(docker run --runtime=io.containerd.wasmtime.v2 --platform=wasm --rm --mount type=bind,source="$(pwd)",target=/app sangeetakakati/sort-rust-wasm:wasm 2>&1 | grep "Main function started at:" | awk '{print $5}')
            pull_time=$((main_start_time - script_start_time))
            total_pull_time=$((total_pull_time + pull_time))
            echo "Rust Sort Wasm Trial $i (Pull, $arch): Startup Time = $pull_time ms"
        done

        echo "Average Rust Sort Wasm cold start time from pull ($arch): $((total_pull_time / trials)) ms"
    done
}

measure_wasm_tinygo() {
    trials=10
    architectures=("wasm")

    echo "Measuring Wasm TinyGo..."

    for arch in "${architectures[@]}"; do
        echo "Architecture: $arch"
        total_pull_time=0

        for i in $(seq 1 $trials); do
            # Cold start time from pull
            docker rmi sangeetakakati/sort-tinygo-wasm:wasm > /dev/null 2>&1
            script_start_time=$(date +%s%3N)
            echo "Script start time: ${script_start_time} ms"
            main_start_time=$(docker run --runtime=io.containerd.wasmtime.v2 --platform=wasm --rm --mount type=bind,source="$(pwd)",target=/app sangeetakakati/sort-tinygo-wasm:wasm 2>&1 | grep "Main function started at:" | awk '{print $5}')
            pull_time=$((main_start_time - script_start_time))
            total_pull_time=$((total_pull_time + pull_time))
            echo "TinyGo Sort Wasm Trial $i (Pull, $arch): Startup Time = $pull_time ms"
        done

        echo "Average TinyGo Sort Wasm cold start time from pull ($arch): $((total_pull_time / trials)) ms"
    done
}

measure_wasm_cpp() {
    trials=10
    architectures=("wasm")

    echo "Measuring Wasm C++..."

    for arch in "${architectures[@]}"; do
        echo "Architecture: $arch"
        total_pull_time=0

        for i in $(seq 1 $trials); do
            # Cold start time from pull
            docker rmi sangeetakakati/cpp-sort-wasm:wasm > /dev/null 2>&1
            script_start_time=$(date +%s%3N)
            echo "Script start time: ${script_start_time} ms"
            main_start_time=$(docker run --runtime=io.containerd.wasmtime.v2 --platform=wasm --rm --mount type=bind,source="$(pwd)",target=/app sangeetakakati/cpp-sort-wasm:wasm 2>&1 | grep "Main function started at:" | awk '{print $5}')
            pull_time=$((main_start_time - script_start_time))
            total_pull_time=$((total_pull_time + pull_time))
            echo "C++ Sort Wasm Trial $i (Pull, $arch): Startup Time = $pull_time ms"
        done

        echo "Average C++ Sort Wasm cold start time from pull ($arch): $((total_pull_time / trials)) ms"
    done
}

host_arch=$(detect_architecture)

# native all
measure_native_rust $host_arch
measure_native_tinygo $host_arch
measure_native_cpp $host_arch

# wasm
measure_wasm_rust
measure_wasm_tinygo
measure_wasm_cpp

