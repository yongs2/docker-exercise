# bulid stage
FROM golang:1.13.0 AS build
LABEL mainterner yongs2@hotmail.com

# clone
RUN go get github.com/nats-io/nats.go/

# build
WORKDIR /go/src/github.com/nats-io/nats.go/examples/nats-sub
RUN go build

# final stage
FROM golang:1.13.0
ENV NATS_URL nats
ENV SUBJECT foo
COPY --from=build /go/src/github.com/nats-io/nats.go/examples/nats-sub/nats-sub /go/bin

WORKDIR /go/
ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "/go/entrypoint.sh" ]
