# Build stage
FROM tinygo/tinygo:latest AS build

WORKDIR /app
COPY main.go .

# Build the Go program using TinyGo with optimizations
RUN tinygo build -opt=2 -o /app/tinygo_native main.go

# Runtime stage
FROM scratch
COPY --from=build /app/tinygo_native /tinygo_native
COPY input.txt /input.txt

ENTRYPOINT ["/tinygo_native", "/input.txt", "/output.txt"]

