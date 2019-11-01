FROM balenalib/intel-nuc-alpine-golang:1.12 as builder
WORKDIR /go/src/github.com/fhmq/hmq
COPY . .
RUN CGO_ENABLED=0 go build -o hmq -a -ldflags '-extldflags "-static"' .


FROM balenalib/intel-nuc-alpine:3.8 as toe
WORKDIR /
COPY --from=builder /go/src/github.com/fhmq/hmq/hmq .
EXPOSE 1883
CMD ["/hmq"]
