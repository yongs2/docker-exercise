.PHONY: build
build:
	docker build -t enumbind .

.PHONY: run
run:
	docker run -i -p 192.168.0.210:53:53/tcp -p 192.168.0.210:53:53/udp -e DOCKER_LOGS=1 --name enumbind enumbind || :

.PHONY: exec
exec:
	docker exec -it enumbind /bin/bash

.PHONY: stop
stop:
	docker stop enumbind || :

