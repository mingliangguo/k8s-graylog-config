# README

## setup graylog

- https://github.com/mouaadaassou/K8s-Graylog
- https://dzone.com/articles/graylog-with-kubernetes-in-gke

#### NOTE

- to login, use admin/admin
- the ingress configure the host name of graylog as - `graylog.garyhub`, in order to access using the url, a host-override is needed.


### Send logs to graylog

```bash
curl -XPOST http://graylog3:12201/gelf -p0 -d '{"short_message":"Hello there", "host":"alpine-k8s.org", "facility":"test", "_foo":"bar"}'
```


## setup ingress for kind

Follow this guide: https://kind.sigs.k8s.io/docs/user/ingress/

```bash
./kind-setup-docker-registry.sh

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

```

### Restart docker registry if needed

```bash
docker run -d --restart=always -p 5000:5000 --name kind-registry registry:2
```

## Configure input source in graylog



## Aggregate logs to the fluentd daemonset

- https://medium.com/@bahubalishetti/aggregating-application-logs-from-kubernetes-clusters-using-fluentd-to-log-intelligence-91da5f536692
  - This article said that: `privilege access to install fluentd daemonsets into “kube-system” namespace.` Not sure if it's really necessary. I do notice that infohub fluentd daemonset is installed in the default namespace where the other infohub service is installed.

## References

- graylog setup: https://github.com/mouaadaassou/K8s-Graylog
- graylog input config for fluentd: https://docs.fluentd.org/how-to-guides/graylog2
