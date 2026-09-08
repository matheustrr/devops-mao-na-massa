#!/usr/bin/env bash

# Corrigindo repositórios do CentOS 7 (Vault)
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*.repo
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

# Instalando EPEL e Ansible
yum install -y epel-release
yum install -y ansible sshpass vim

# Configurando o inventário padrão (/etc/ansible/hosts)
mkdir -p /etc/ansible
cat <<EOT > /etc/ansible/hosts
[apps]
app01 ansible_user=vagrant ansible_password=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[dbs]
db01 ansible_user=vagrant ansible_password=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOT

# ==============================================================================
# OPCIONAL: Se no futuro você quiser usar Chaves SSH em vez de senha:
# 1. No control-node, gere a chave (caso não exista): ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
# 2. Copie a chave para as máquinas alvo usando o sshpass:
#    sshpass -p 'vagrant' ssh-copy-id -o StrictHostKeyChecking=no vagrant@192.168.1.3
#    sshpass -p 'vagrant' ssh-copy-id -o StrictHostKeyChecking=no vagrant@192.168.1.4
# 3. No arquivo de inventário (/etc/ansible/hosts), remova o 'ansible_password=vagrant'.
# ==============================================================================