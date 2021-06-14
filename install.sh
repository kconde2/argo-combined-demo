k apply -k argo-cd/overlays/production
kubens
m enable nginx
microk8s enable ingress


k apply -k argo-cd/overlays/production
# k delete -k argo-cd/overlays/production



microk8s enable ingress
k9s
kubens
kubectl --namespace argocd get secret argocd-initial-admin-secret --output jsonpath="{.data.password}" | base64 --decode
export PASS=$(kubectl --namespace argocd get secret argocd-initial-admin-secret --output jsonpath="{.data.password}" | base64 --decode)
argocd login --insecure --username admin --password $PASS --grpc-web argo.kube.kabaconde.com
VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
chmod +x /usr/local/bin/argocd
argocd account update-password --current-password $PASS --new-password admin

# kubectl --namespace argocd rollout status deploymnet argocd-server

k apply -f projects.yaml
k apply -f apps.yaml
