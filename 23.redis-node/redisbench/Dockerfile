# build stage
FROM docker.io/golang:latest AS build

RUN cd $GOPATH/src \
    && git clone https://github.com/panjiang/redisbench
RUN cd $GOPATH/src/redisbench \
    && go install .

# final stage
FROM ubuntu:latest
COPY --from=build /go/bin/redisbench /redisbench

CMD ["/redisbench"]
