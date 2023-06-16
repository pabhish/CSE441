#!/bin/bash

app="$1"
docker build -t ${app} .
docker push ${app}
docker run -d -p 8090:8080 ${app}
