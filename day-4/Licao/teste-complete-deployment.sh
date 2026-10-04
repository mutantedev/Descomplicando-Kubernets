#!/bin/bash

# SUBSTITUI A VERSÃO DO NGINX
echo
echo "SUBSTITUINDO VERSÃO NO ARQUIVO"
sed -i 's/nginx:1.18.0/nginx:1.19.0/g' complete-deployment.yaml

kubectl apply -f complete-deployment.yaml

echo "=== Aguardando rollout da nova versão ==="
kubectl rollout status deployment complete-deployment

echo
echo "=== Pods ==="
kubectl get pods

sleep 10

echo
echo "=== Imagem utilizada ==="
kubectl describe deployments.apps complete-deployment | grep "Image:"

sleep 10

# VOLTAR A VERSÃO ANTIGA COM ROLLOUT

echo
echo "=== Desfazendo rollout ==="
kubectl rollout undo deployments complete-deployment

echo
echo "=== Aguardando rollback ==="
kubectl rollout status deployment complete-deployment

echo
echo "=== Pods após rollback ==="
kubectl get pods

sleep 10

echo
echo "=== Imagem após rollback ==="
kubectl describe deployments.apps complete-deployment | grep "Image:"

echo
echo "PRONTINHO, DEPLOYMENT CRIADO, ATUALIZADO E REVERTIDO"

echo
echo "VOLTANDO A VERSÃO ANTIGA NO ARQUIVO"

sed -i 's/nginx:1.19.0/nginx:1.18.0/g' complete-deployment.yaml
