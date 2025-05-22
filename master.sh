#!/bin/bash

# Atualiza pacotes e instala dependências
apt-get update
apt-get install -y nfs-kernel-server apache2 docker.io

# Cria diretório compartilhado para NFS
mkdir -p /var/www/shared
chown nobody:nogroup /var/www/shared
chmod 777 /var/www/shared

# Configura exportação NFS
echo "/var/www/shared 10.10.10.0/24(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
exportfs -a
systemctl restart nfs-kernel-server

# Inicia Docker Swarm
docker swarm init --advertise-addr=10.10.10.100

# Gera script worker.sh com o comando de join no Swarm
docker swarm join-token worker | grep docker > /vagrant/worker.sh
chmod +x /vagrant/worker.sh
