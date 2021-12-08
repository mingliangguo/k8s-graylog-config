#!/usr/bin/env bash

MANIFEST_DIR=$HOME/work/fluentd-setup/k8s
kubectl apply -f $MANIFEST_DIR/fluentd
kubectl apply -f $MANIFEST_DIR/graylog
kubectl apply -f $MANIFEST_DIR/ingress
