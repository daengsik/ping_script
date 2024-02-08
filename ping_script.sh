#!/bin/bash
# CSV 파일 지정
csv_file="testing_csv.csv"

# CSV 파일 유무 확인
if [ ! -f "$csv_file" ]; then
	echo "CSV file doesn't exist: $csv_file"
	exit 1
fi

# 임시 파일 생성
#temp_file=$(mktemp)

# IFS(,) 지정하여 필드 분리
IFS=","

# 파일을 읽어서 처리
while IFS=, read -r index ip_addr desc result; do
	if [ "$index" == "INDEX" ]; then
		result="SKIP"
	else
		ping -c 1 -w 1 "$ip_addr" > /dev/null
	fi
	if [ $? -eq 0 ]; then
		result="OK"
	else
		result="FAIL"
	fi

  	# 결과를 업데이트한 행을 임시 파일에 추가
	#echo "$index,$ip_addr,$desc,$result" >> "$temp_file"

  	# 결과 출력
	printf "INDEX: %-5s, IPADDR: %-15s, DESC: %-20s, RESULT: %s\n" "$index" "$ip_addr" "$desc" "$result"

done < "$csv_file"

# 임시 파일을 원본 파일로 이동
#mv "$temp_file" "$csv_file"