# Build Stage
FROM alpine:latest AS builder
WORKDIR /usr/src/myapp

RUN apk add --no-cache clang make libc-dev

COPY sort.cpp ./sort.cpp
RUN clang++ sort.cpp -o sort -static -O3

# Runtime Stage
FROM scratch
COPY --from=builder /usr/src/myapp/sort /sort
COPY input.txt /input.txt

CMD ["/sort", "/input.txt", "/output.txt"]
