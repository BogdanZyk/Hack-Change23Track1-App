FROM golang:1.21 as builder
WORKDIR /app

COPY go.mod go.sum .
RUN go mod download
COPY . .
RUN go build -o audio-stream

FROM ubuntu:latest

WORKDIR /app

COPY --from=builder /app/audio-stream audio-stream

CMD ./audio-stream