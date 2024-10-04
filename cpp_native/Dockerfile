FROM gcc:latest AS builder
WORKDIR /usr/src/app

COPY sort.cpp ./sort.cpp
RUN g++ sort.cpp -o sort -static -O2

# Runtime Stage
FROM scratch
COPY --from=builder /usr/src/app/sort /sort
COPY input.txt /input.txt
CMD ["/sort"]

