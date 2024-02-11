# PingScript.sh
csv 파일을 참조하여 ping 하고, 결과를 csv 파일에 기록하는 쉘스크립트
<br><br>
## 사용법
<br>
1. Linux 환경에서 사용할 경우, vi 또는 nano 편집기를 사용하여 21 Line 의 주석을 해제하고, 22 Line 주석처리 필요
<br><br>

![스크린샷 2024-02-11 105646](https://github.com/daengsik/ping_script/assets/62642918/b4f8c823-8db3-4d19-8485-b57f232c7876)

2. 쉘 스크립트 권한 부여 > **chmod +x ping_script.sh**
3. 쉘 스크립트 권한 부여 > **chmod 755 ping_script.sh**
4. 개행문자 에러 발생시 > **sed -i 's/\r$//' ping_script.sh**

![스크린샷 2024-02-11 110116](https://github.com/daengsik/ping_script/assets/62642918/d6cc1144-e9db-4660-950a-2f3c53f70248)

스크립트 실행
