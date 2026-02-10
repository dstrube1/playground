# from https://github.com/a2labsllc/DEPOT-final/blob/main/deployment/v2/cleanup.md

echo "Removing all helm releases in namespace..."
helm uninstall -n oai-tutorial $(helm list -q -n oai-tutorial)

#If you set up Prometheus and Grafana, you can clean it up:
#helm uninstall prom-graf-kube

########################################################
#Delete Kubernetes metadata
echo "Deleting Kubernetes namespace..."
kubectl delete namespace oai-tutorial

echo "Cleaning up docker secret..."
kubectl delete secret regcred
########################################################

echo "Done."