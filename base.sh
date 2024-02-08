# testing script
ping_node=(
192.168.6.1
192.168.6.2
192.168.6.3
192.168.6.254
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