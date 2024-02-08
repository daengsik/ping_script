# PingScript.sh
csv 파일을 참조하여 ping 하고, 결과를 csv 파일에 기록하는 쉘스크립트

## 사용법
1. csv 파일의 1행을 제외하고 편집 또는 작성
2. 쉘 스크립트에서 참조할 csv 파일의 파일명 지정
3. 시스템(Windows / Linux) 에 맞는 ping command 주석해제 및 주석처리 (Default : Windows)
4. 쉘 스크립트 권한부여 > chmod +x ping_script.sh
5. 쉘 스크립트 권한부여 > chmod 755 ping_script.sh
6. 개행문자 에러 발생시 > sed -i 's/\r$//' ping_script.sh
8. 스크립트 실행
9. 실행결과 및 csv 파일 확인
