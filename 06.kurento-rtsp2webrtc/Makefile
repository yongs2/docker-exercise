.PHONY: build
build:
	docker build -t rtsp2webrtc -f Dockerfile .

.PHONY: run
run:
	docker run --rm --name rtsp2webrtc -p 7080:8080 rtsp2webrtc || :

.PHONY: exec
exec:
	docker exec -it rtsp2webrtc /bin/bash

.PHONY: stop
stop:
	docker stop rtsp2webrtc || :

.PHONY: logs
logs:
	docker logs -f rtsp2webrtc || :
