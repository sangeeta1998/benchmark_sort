FROM scratch
COPY target/wasm32-wasi/release/rust_wasm_optimized.wasm  /rust_wasm.wasm
COPY input.txt /input.txt
ENTRYPOINT ["/rust_wasm.wasm", "/input.txt", "/output.txt"]

