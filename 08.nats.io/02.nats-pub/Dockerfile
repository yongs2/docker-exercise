# bulid stage
FROM golang:1.13.0 AS build
LABEL mainterner yongs2@hotmail.com

# clone
RUN go get github.com/nats-io/nats.go/

# build
WORKDIR /go/src/github.com/nats-io/nats.go/examples/nats-pub
RUN go build

# final stage
FROM golang:1.13.0
ENV NATS_URL nats
ENV SUBJECT foo
ENV MESSAGE "test message"
COPY --from=build /go/src/github.com/nats-io/nats.go/examples/nats-pub/nats-pub /go/bin

WORKDIR /go/
ADD *.sh /go/bin/
RUN chmod +x /go/bin/*.sh
CMD [ "/go/bin/entrypoint.sh" ]
