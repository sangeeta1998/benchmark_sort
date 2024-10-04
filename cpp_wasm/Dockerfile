FROM scratch
COPY sort_opt.wasm  /sort_wasm.wasm
COPY input.txt /input.txt
ENTRYPOINT ["/sort_wasm.wasm", "/input.txt", "/output.txt"]

