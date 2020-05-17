# encoding/json 패키지의 성능 비교

## golang 버전별 encoding/json 성능 비교

- [Go: Is the encoding/json Package Really Slow?](https://medium.com/a-journey-with-go/go-is-the-encoding-json-package-really-slow-62b64d54b148)

- golang 1.12, 1.13, 1.14

```sh
go version
go test -bench=. -benchmem -count=10
```

- test
```sh
make
cat src/*.log
```

## json 패키지 성능 비교

- [json-iterator](https://github.com/json-iterator/go), Star:7.6k, Latest commit
55287ed 8 days ago

- [ffjson: faster JSON for Go](https://github.com/pquerna/ffjson), Star:2.6k, Latest commit
aa0246c on 30 Sep 2019

- [jettison : Fast and flexible JSON encoder for Go](https://github.com/wI2L/jettison), Star: 78, Latest commit 9314658 on 14 Mar

- [jsonport : a simple and high performance json reader without pain, only Unmarshal](https://github.com/xiaost/jsonport), Star: 15, Latest commit 139b207 on 3 Apr

## 참고 자료 

- [Best Practices for Speeding Up JSON Encoding and Decoding in Go](https://yalantis.com/blog/speed-up-json-encoding-decoding/)
- [Performance analysis of golang JSON](https://developpaper.com/performance-analysis-of-golang-json/)
- [JSON Parsing and Benchmarking in Go](https://codeburst.io/json-parsing-and-benchmarking-in-go-a5ccdf7bbd2b)

- [Go encoding/json 패키지](https://jeonghwan-kim.github.io/dev/2019/01/18/go-encoding-json.html)
