# Setup Grafana and Prometheus

Basically I am following this [guide](https://computingforgeeks.com/setup-prometheus-and-grafana-on-kubernetes/) to setup grafana and prometheus.

Here is the brief summary of the commands used:

```bash
# clone the repo
git clone https://github.com/prometheus-operator/kube-prometheus.git

# navigate to the cloned folder
cd kube-prometheus

# Create the monitoring namespace and CRDs
kubectl create -f manifest/setup

# Deploy prometheus and grafan
kubectl create -f manifest
```
