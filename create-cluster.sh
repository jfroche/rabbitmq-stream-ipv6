#!/usr/bin/env bash
set -euo pipefail

#sudo iptables -I DOCKER-USER -p tcp  --match multiport --dports 6000:6500 -j DROP

sudo rm erlang.cookie
umask 001
echo "0RySMGuZIF" > erlang.cookie
sudo chown 999 erlang.cookie
sudo chmod 600 erlang.cookie

docker compose down --remove-orphans
docker compose up --force-recreate --remove-orphans -d --wait

sudo nsenter -t "$(docker inspect compose-rabbitmq-1-1|jq '.[].State.Pid')" -n ss -n
