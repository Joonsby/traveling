프로젝트 로컬 실행 설정 안내

이 문서는 로컬에서 이 웹 애플리케이션을 실행하기 위한 최소 설정과 준비 과정을 정리합니다.

이미 자동으로 수행한 작업
- MyBatis 설정(`mybatis/dbcon.xml`)과 DB 정보(`config/dbinfo.properties`)를
  `WebContent/WEB-INF/classes` 아래에 복사했습니다. (Tomcat 배포 시 클래스패스에 추가되도록)
- 모든 MyBatis 매퍼 XML들을 `WebContent/WEB-INF/classes/com/traveling/.../dao/`로 복사했습니다.

해야 할 추가 작업 (사용자 환경에서 수행해야 함)
1) MySQL 준비
   - MySQL이 설치되어 있고 실행 중인지 확인하세요.
   - 데이터베이스 생성 예시:
     ```sql
     CREATE DATABASE IF NOT EXISTS project CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
     CREATE USER 'joonsby'@'localhost' IDENTIFIED BY 'xhddlf336!';
     GRANT ALL PRIVILEGES ON project.* TO 'joonsby'@'localhost';
     FLUSH PRIVILEGES;
     ```
   - 현재 `config/dbinfo.properties`의 기본(local) 계정은 `root`와 비밀번호 `xhddlf336!`로 설정되어 있습니다. 필요하면 파일을 수정하세요:
     `traveling_project/WebContent/WEB-INF/classes/config/dbinfo.properties`

2) WEB-INF/lib 정리 (중요)
   - `traveling_project/WebContent/WEB-INF/lib` 폴더에서 다음을 확인하세요:
     - 절대 제거해야 할 것: `servlet-api.jar` (Tomcat이 제공함 → WAR에 포함하면 문제 발생)
     - 드라이버 중복 제거: `mysql-connector-java-5.1.49-bin.jar` 와 `mysql-connector-j-8.0.33.jar` 둘 중 하나만 사용하세요. 권장: `mysql-connector-j-8.0.33.jar`.

3) IntelliJ 설정
   - Project SDK: JDK 8 또는 11 권장
   - `traveling_project/resources`를 Resources Root로 마크하거나, 이미 복사한 `WebContent/WEB-INF/classes`를 통해 자원 접근이 가능하므로 크게 신경쓰지 않아도 됩니다.
   - Artifacts: Web Application: Exploded (WebContent 기준) 생성 → Tomcat Run Configuration에 배포
   - Run Configuration VM options에 시스템 프로퍼티로 환경을 바꾸려면 추가: `-Denv=dev` 등

4) Tomcat 실행(IDE 또는 직접)
   - IntelliJ에서 Tomcat Local Run 설정 후 배포하고 실행
   - 직접 실행(예시 PowerShell, Tomcat 경로를 실제값으로 바꿔서 사용):
     ```powershell
     $env:CATALINA_HOME = "C:\path\to\apache-tomcat-9.0.xx"
     & "$env:CATALINA_HOME\bin\startup.bat"
     ```

5) 접속 URL
   - 기본: http://localhost:8080/<context>/main
   - IntelliJ에서 context가 프로젝트 루트(`/`)로 설정되어 있으면 http://localhost:8080/main 로 접속

문제가 발생하면 확인할 항목
- Tomcat 로그(IDE Run 창 또는 `tomcat/logs/catalina.out`)
- DB 접속: 커넥션 에러/계정/포트 확인
- ClassNotFound: 필요한 JAR가 `WEB-INF/lib`에 있는지 확인

문의/추가 요청
- IntelliJ에서 아티팩트/런 설정을 단계별로 화면 캡처 포함해 안내를 원하시면 알려주세요.
- `WEB-INF/lib` 정리(어떤 JAR를 삭제할지, 권장 목록)을 자동으로 스크립트로 만들게 해달라고 요청 가능

