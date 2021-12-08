#!/usr/bin/env bash

./gradlew build -x check

docker build -t localhost:5000/boot-app .
docker push localhost:5000/boot-app
kubectl rollout restart deployment ming-bootapp
