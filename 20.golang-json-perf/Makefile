#MAKEFILE

COMMAND=/bin/bash -c "chmod +x /go/src/run_test.sh;/go/src/run_test.sh"

all: go_1_12 go_1_13 go_1_14

.PHONY: go_1_12
go_1_12:
	docker run --rm --name go_1_12 \
		-v `pwd`/src:/go/src \
		-w /go/src \
		golang:1.12.17-stretch \
		${COMMAND}

.PHONY: go_1_13
go_1_13:
	docker run -it --rm --name go_1_13 \
		-v `pwd`/src:/go/src \
		-w /go/src \
		golang:1.13.10-stretch \
		${COMMAND}

.PHONY: go_1_14
go_1_14:
	docker run -it --rm --name go_1_14 \
		-v `pwd`/src:/go/src \
		-w /go/src \
		golang:1.14.3-stretch \
		${COMMAND}

.PHONY: go_dev
go_dev:
	docker run -it --rm --name go_dev \
		-v `pwd`/src:/go/src \
		-w /go/src \
		golang:1.14.3-stretch \
		/bin/bash

clean:
	rm -f `pwd`/src/*.log
	