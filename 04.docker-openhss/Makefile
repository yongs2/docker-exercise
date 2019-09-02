.PHONY: build
build:
	docker build -t openhss:centos7 .

.PHONY: run
run:
	docker run -d --rm --detach --privileged=true -p 3868:3868 -p 8080:8080 --name openhss-centos7 openhss:centos7 || :

.PHONY: exec
exec:
	docker exec -it openhss-centos7 /bin/bash

.PHONY: stop
stop:
	docker stop openhss-centos7 || :
