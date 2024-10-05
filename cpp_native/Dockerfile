# Build Stage
FROM alpine:latest AS builder
WORKDIR /usr/src/app

# Install necessary packages
RUN apk add --no-cache g++ make

COPY sort.cpp ./sort.cpp
RUN g++ sort.cpp -o sort -static -O2

# Runtime Stage
FROM scratch
COPY --from=builder /usr/src/app/sort /sort
COPY input.txt /input.txt
CMD ["/sort"]
