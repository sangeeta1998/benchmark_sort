FROM scratch
COPY tinygo_wasm_optimized.wasm /tinygo_wasm.wasm
COPY input.txt /input.txt
ENTRYPOINT ["/tinygo_wasm.wasm", "/input.txt", "/output.txt"]

