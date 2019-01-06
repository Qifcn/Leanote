#! /bin/bash
cd ~
yum install -y wget
wget https://sourceforge.net/projects/leanote-bin/files/2.6.1/leanote-linux-amd64-v2.6.1.bin.tar.gz
tar -zxv leanote-linux-amd64-v2.6.1.bin.tar.gz
cat <<EOF | sudo tee /etc/yum.repos.d/mongodb-org-3.6.repo
[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/testing/x86_64/
gpgcheck=0
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
EOF
cd leanote
mkdir data
cd ~
mongod --fork --syslog --dbpath /leanote/data
mongorestore -h localhost -d leanote --dir /leanote/mongodb_backup/leanote_install_data/
cd /leanote/bin/
bash run.sh
