#!/usr/bin/env bash
# 로컬에서 4개 모듈을 JDK 11 로 빌드합니다(테스트 제외 — DB 불필요).
set -euo pipefail
cd "$(dirname "$0")/.."

# 이 맥에 설치된 Corretto 11 경로(다르면 수정).
JDK11="${JDK11:-/Users/paulyu/Library/Java/JavaVirtualMachines/corretto-11.0.22/Contents/Home}"
[ -x "$JDK11/bin/java" ] || { echo "JDK11 경로가 잘못됨: $JDK11"; echo "/usr/libexec/java_home -V 로 확인 후 JDK11 환경변수로 지정하세요."; exit 1; }

export JAVA_HOME="$JDK11"
export PATH="$JAVA_HOME/bin:$PATH"
chmod +x gradlew

echo "### JDK: $(java -version 2>&1 | head -1) ###"
./gradlew clean assemble -x test --console=plain

echo
echo "### 산출물 ###"
ls -lh gallery-board/build/libs/*.jar
ls -lh gallery-manager/build/libs/ROOT.war
ls -lh gallery-staff/build/libs/*.jar
ls -lh gallery-talk/build/libs/*.jar
