rust_native_image="sangeetakakati/sort-rust-native:latest"
tinygo_native_image="sangeetakakati/sort-tinygo-native:latest"
cpp_native_image="sangeetakakati/cpp-sort-native:latest"
cpp_wasm_image="sangeetakakati/cpp-sort-wasm:wasm"
rust_wasm_image="sangeetakakati/sort-rust-wasm:wasm"
tinygo_wasm_image="sangeetakakati/sort-tinygo-wasm:wasm"

clean:
	docker rmi $(rust_native_image)
	docker rmi $(tinygo_native_image)
	docker rmi $(cpp_native_image)
	docker rmi $(rust_wasm_image)
	docker rmi $(tinygo_wasm_image)
	docker rmi $(cpp_wasm_image)
	docker container prune -f
