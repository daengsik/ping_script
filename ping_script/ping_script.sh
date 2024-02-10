#!/bin/bash

# CSV 파일 지정
read -e -p "csv 파일지정: " csv_file

if [ ! -f "$csv_file" ]; then
	echo "CSV file doesn't exist: $csv_file"
	exit 1
fi

temp_file=$(mktemp)
ok_count=0
fail_count=0

IFS=","
while IFS=, read -r index ip_addr desc result; do
	if [ "$index" == "INDEX" ]; then
		result="SKIP"
	else
		# 리눅스
		# if ping -c 1 -W 0.5 "$ip_addr" > /dev/null; then
		if ping -n 1 -w 1 "$ip_addr" > /dev/null; then
			result="OK"
		else
			result="FAIL"
		fi
	fi
	if [ result == "SKIP" ]; then
		true
	else
		echo "$index,$ip_addr,$desc,$result" >> "$temp_file"
	fi
	if [ "$result" == "OK" ]; then
   		 printf "INDEX: %-5s, IPADDR: %-14s, DESC: %-20s, RESULT: \033[32m%s\033[0m\n" "$index" "$ip_addr" "$desc" "$result"
	elif [ "$result" == "FAIL" ]; then
    		printf "INDEX: %-5s, IPADDR: %-14s, DESC: %-20s, RESULT: \033[31m%s\033[0m\n" "$index" "$ip_addr" "$desc" "$result"
	else
   		 printf "INDEX: %-5s, IPADDR: %-14s, DESC: %-20s, RESULT: %s\n" "$index" "$ip_addr" "$desc" "$result"
	fi
done < "$csv_file"

mv "$temp_file" "$csv_file"

while IFS=, read -r index ip_addr desc result; do
	if [ "$result" == "OK" ]; then
		((ok_count++))
	elif [ "$result" == "FAIL" ]; then
		((fail_count++))
	fi
done < "$csv_file"

echo "OK Count: $ok_count"
echo "FAIL Count: $fail_count"
