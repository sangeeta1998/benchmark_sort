# Build Stage
FROM alpine:latest AS builder
WORKDIR /usr/src/myapp

RUN apk add --no-cache g++ make

COPY sort.cpp ./sort.cpp
RUN g++ sort.cpp -o sort -static -O3  


# Runtime Stage
FROM scratch
COPY --from=builder /usr/src/myapp/sort /sort
COPY input.txt /input.txt

CMD ["/sort", "/input.txt", "/output.txt"]
