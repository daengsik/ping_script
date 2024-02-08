#!/bin/bash
# CSV 파일 지정
csv_file="testing_csv.csv"

# CSV 파일 유무 확인
if [ ! -f "$csv_file" ]; then
	echo "CSV file doesn't exist: $csv_file"
	exit 1
fi

# 임시 파일 생성
temp_file=$(mktemp)

# IFS(,) 지정하여 필드 분리
IFS=","

# 파일을 읽어서 처리
while IFS=, read -r index ip_addr desc result; do
	if [ "$index" == "INDEX" ]; then
		result="SKIP"
	else
		result="PASS"
		# 리눅스 > ping -c 1 -W 1 "$ip_addr"> /dev/null
		ping -n 1 -w 1 "$ip_addr"> /dev/null
		if [ $? -eq 0 ]; then
			result="OK"
		else
			result="FAIL"
		fi
	fi

  	# 결과를 업데이트한 행을 임시 파일에 추가
	if [ result == "SKIP" ]; then
		true
	else	
		echo "$index,$ip_addr,$desc,$result" >> "$temp_file"
	fi
  	# 결과 출력
	if [ "$result" == "OK" ]; then
   		 printf "INDEX: %-5s, IPADDR: %-14s, DESC: %-20s, RESULT: \033[32m%s\033[0m\n" "$index" "$ip_addr" "$desc" "$result"
	elif [ "$result" == "FAIL" ]; then
    		printf "INDEX: %-5s, IPADDR: %-14s, DESC: %-20s, RESULT: \033[31m%s\033[0m\n" "$index" "$ip_addr" "$desc" "$result"
	else
   		 printf "INDEX: %-5s, IPADDR: %-14s, DESC: %-20s, RESULT: %s\n" "$index" "$ip_addr" "$desc" "$result"
	fi


done < "$csv_file"

# 임시 파일을 원본 파일로 이동
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
