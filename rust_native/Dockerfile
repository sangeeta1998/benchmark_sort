# First, build stage
FROM rust:alpine as builder
WORKDIR /usr/src/myapp

# Installing necessary build dependencies
RUN apk add --no-cache musl-dev gcc upx binutils

COPY Cargo.toml Cargo.lock ./ 
RUN cargo fetch
COPY src/ ./src/
RUN cargo build --release

# Runtime st
FROM scratch
COPY --from=builder /usr/src/myapp/target/release/rust_native /rust_native
COPY input.txt /input.txt

CMD ["/rust_native", "/input.txt", "/output.txt"]

