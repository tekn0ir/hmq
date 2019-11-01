FROM balenalib/raspberrypi3-alpine-golang:1.12 as builder
RUN [ "cross-build-start" ]
WORKDIR /go/src/github.com/fhmq/hmq
COPY . .
RUN CGO_ENABLED=0 go build -o hmq -a -ldflags '-extldflags "-static"' .
RUN [ "cross-build-end" ]

FROM balenalib/raspberrypi3-alpine:3.8 as hmq
WORKDIR /
COPY --from=builder /go/src/github.com/fhmq/hmq/hmq .
EXPOSE 1883
CMD ["/hmq"]
