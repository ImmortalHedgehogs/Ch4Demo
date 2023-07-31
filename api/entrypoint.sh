#!/usr/bin/env sh
jar=devops-knowledge-share-api.jar

if [ x"${JAVA_ENABLE_DEBUG}" != x ] && [ "${JAVA_ENABLE_DEBUG}" != "false" ]; then
  echo "Starting with debug enabled"
  java -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=5005,suspend=n -jar $jar
else
java -jar $jar
fi
