.PHONY: run
run: gopher.go
	go run .

gopher.go: gopher.y
	go generate

.PHONY: build
build:
	go build
