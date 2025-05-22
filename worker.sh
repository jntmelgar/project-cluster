#!/bin/bash

MASTER_IP=$1

# Instala NFS e Apache
apt-get update
apt-get install -y nfs-common apache2

# Cria e monta diretório compartilhado
mkdir -p /var/www/shared
mount "${MASTER_IP}:/var/www/shared" /var/www/shared

# Montagem persistente
echo "${MASTER_IP}:/var/www/shared /var/www/shared nfs defaults 0 0" >> /etc/fstab

# Entra no Swarm
docker swarm join --token SWMTKN-1-3pj8k0i4tn77bd93a0yxhgh36hxuef5q5oyg1732rztnfy29ll-a94q0ipwgrjs4xikzyb4yb3n5 ${MASTER_IP}:2377
