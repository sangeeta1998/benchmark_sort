# Build Stage
FROM rust:alpine AS builder
WORKDIR /usr/src/myapp

COPY Cargo.toml Cargo.lock ./
RUN cargo fetch
COPY src/ ./src/
RUN cargo build --release

# Runtime Stage
FROM scratch
COPY --from=builder /usr/src/myapp/target/release/rust_native /rust_native
COPY input.txt /input.txt

CMD ["/rust_native", "/input.txt", "/output.txt"]
