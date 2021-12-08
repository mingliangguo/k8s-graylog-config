#!/usr/bin/env bash

docker build -t localhost:5000/go-app .
docker push localhost:5000/go-app
kubectl rollout restart deployment ming-go
