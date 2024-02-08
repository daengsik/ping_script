#!/bin/sh
ping_node=(
192.168.0.61
192.168.0.62
192.168.0.63
192.168.0.64
)

csv_file="testing_csv.csv"
if [ ! -f "$csv_file" ]; then
	echo "CSV file dosen't exist $csv_file"
	exit 1
fi

IFS=","
while read -r field1 field2 field3; do
	echo "field 1: $field1, field 2: $field2, field 3: $field3"
done < "$csv_file"

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