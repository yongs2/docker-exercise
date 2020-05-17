package main

import (
	"encoding/json"
	"os"
	"strings"
	"testing"

	"github.com/json-iterator/go"
	"github.com/pquerna/ffjson/ffjson"
	"github.com/wI2L/jettison"
	"github.com/xiaost/jsonport"
)

type JSON struct {
	Foo int
	Bar string
	Baz float64
}

var jsonData JSON = JSON{
	Foo: 123,
	Bar: `benchmark`,
	Baz: 123.456,
}
var jsonString string = `{"foo": 1, "bar": "my string", bar: 1.123}`

// encoding/json
func Benchmark_Json_Marshall(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_, _ = json.Marshal(&jsonData)
	}
}

func Benchmark_Json_Unmarshal(b *testing.B) {
	bytes := []byte(jsonString)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		j := JSON{}
		_ = json.Unmarshal(bytes, &j)
	}
}

// encoder/decoder
func Benchmark_Json_Encoder(b *testing.B) {
	encoder := json.NewEncoder(os.Stdin)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		encoder.Encode(jsonData)
	}
}

func Benchmark_Json_Decoder(b *testing.B) {
	decoder := json.NewDecoder(strings.NewReader(jsonString))
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		j := JSON{}
		decoder.Decode(&j)
	}
}

func Benchmark_Jsoniter_Marshall(b *testing.B) {
	//var json = jsoniter.ConfigCompatibleWithStandardLibrary
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_, _ = jsoniter.Marshal(&jsonData)
	}
}

func Benchmark_Jsoniter_Unmarshal(b *testing.B) {
	//var json = jsoniter.ConfigCompatibleWithStandardLibrary
	bytes := []byte(jsonString)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		j := JSON{}
		_ = jsoniter.Unmarshal(bytes, &j)
	}
}

func Benchmark_ffjson_Marshall(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_, _ = ffjson.Marshal(&jsonData)
	}
}

func Benchmark_ffjson_Unmarshal(b *testing.B) {
	bytes := []byte(jsonString)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		j := JSON{}
		_ = ffjson.Unmarshal(bytes, &j)
	}
}

func Benchmark_jettison_Marshall(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_, _ = jettison.Marshal(&jsonData)
	}
}

func Benchmark_jsonport_Unmarshall(b *testing.B) {
	bytes := []byte(jsonString)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_, _ = jsonport.Unmarshal(bytes)
	}
}
