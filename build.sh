#!/bin/bash

mkdir -p ./build

# Build the conditions
VERSION=$(shell git describe --tags --exact-match 2>/dev/null || echo "latest")
jq --arg VERSION $VERSION \
    -s '{ version: $VERSION, rules: map(.) }' ./conditions/*.json > ./build/rules.json

# Build the image
podman build -t quay.io/redhatinsights/insights-operator-gathering-conditions:latest .