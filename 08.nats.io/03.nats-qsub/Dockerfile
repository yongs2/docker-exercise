# bulid stage
FROM golang:1.13.0 AS build
LABEL mainterner yongs2@hotmail.com

# clone
RUN go get github.com/nats-io/nats.go/

# build
WORKDIR /go/src/github.com/nats-io/nats.go/examples/nats-qsub
RUN go build

# final stage
FROM golang:1.13.0
ENV NATS_URL nats
ENV SUBJECT foo
ENV QUEUE my-queue
COPY --from=build /go/src/github.com/nats-io/nats.go/examples/nats-qsub/nats-qsub /go/bin

WORKDIR /go/
ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "/go/entrypoint.sh" ]
