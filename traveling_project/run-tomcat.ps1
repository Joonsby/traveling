# Tomcat 시작 스크립트 템플릿
# 사용 전에 $CATALINA_HOME 값을 본인 Tomcat 설치 경로로 수정하세요.

$CATALINA_HOME = "C:\\path\\to\\apache-tomcat-9.0.xx"
if (-Not (Test-Path $CATALINA_HOME)) {
    Write-Error "CATALINA_HOME 경로를 확인하세요: $CATALINA_HOME"
    exit 1
}

# 환경 프로퍼티 지정(예: dev로 실행하려면 -Denv=dev)
$VM_OPTIONS = "-Denv=local"

& "$CATALINA_HOME\bin\startup.bat" $VM_OPTIONS
Write-Host "Tomcat 시작 명령 실행됨. 로그를 확인하세요."
