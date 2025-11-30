#!/bin/bash

# Копируем файлы в нужное место
cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /opt/apache-tomcat-9.0.34/webapps/ 2>/dev/null || true
