#!/bin/bash

# SUBSTITUI A VERSÃO DO NGINX
echo
echo "SUBSTITUINDO VERSÃO NO ARQUIVO"
sed -i 's/nginx:1.15.0/nginx:1.16.0/g' estrategy-deployment.yaml

kubectl apply -f estrategy-deployment.yaml

echo "=== Aguardando rollout da nova versão ==="
kubectl rollout status deployment estrategy-deployment

echo
echo "=== Pods ==="
kubectl get pods

sleep 10

echo
echo "=== Imagem utilizada ==="
kubectl describe deployments.apps estrategy-deployment | grep "Image:"

sleep 10

# VOLTAR A VERSÃO ANTIGA COM ROLLOUT

echo
echo "=== Desfazendo rollout ==="
kubectl rollout undo deployments estrategy-deployment

echo
echo "=== Aguardando rollback ==="
kubectl rollout status deployment estrategy-deployment

echo
echo "=== Pods após rollback ==="
kubectl get pods

sleep 10

echo
echo "=== Imagem após rollback ==="
kubectl describe deployments.apps estrategy-deployment | grep "Image:"

echo
echo "PRONTINHO, DEPLOYMENT CRIADO, ATUALIZADO E REVERTIDO"

echo
echo "VOLTANDO A VERSÃO ANTIGA NO ARQUIVO"

sed -i 's/nginx:1.16.0/nginx:1.15.0/g' complete-deployment.yaml
