#!/bin/sh

go get github.com/json-iterator/go
go get github.com/pquerna/ffjson/ffjson
go get github.com/wI2L/jettison
go get github.com/cespare/prettybench

GO_VERSION=`go version | tr ' '/ _`
RESULT=result_${GO_VERSION}.log

go test -bench=. -benchmem -count=10 | prettybench >> ${RESULT}
# go test -bench=. -benchmem | prettybench
# go test -bench=. -benchmem -memprofile=mem.out; go tool pprof mem.out
## (pprof) top
## (pprof) list Marshal
