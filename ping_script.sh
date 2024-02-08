#!/bin/sh
ping_node=(
192.168.0.61
192.168.0.62
192.168.0.63
192.168.0.64
)

for list in ${ping_node[@]}
do
	ping -c 1 -W 1 "$list" > /dev/null
	if [ $? -eq 0 ]; then
	echo "node $list is up"
	sleep 0.5
	else
	echo "node $list is down"
	fi
done