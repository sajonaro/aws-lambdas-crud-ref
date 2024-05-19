#!/usr/bin/env bash

docker build -t phpmyfuntion .

docker run -p 9001:8080 phpmyfuntion:latest

http "http://localhost:9001/2015-03-31/functions/function/invocations"