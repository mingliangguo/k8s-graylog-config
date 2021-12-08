#!/usr/bin/env bash

docker build -t localhost:5000/toolbox .
docker push localhost:5000/toolbox
kubectl rollout restart pod toolbox
