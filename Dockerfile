FROM ubuntu:20.04
#FROM tomcat:9.0-jdk11
LABEL authors="Andre"

COPY header /tmp
COPY footer /tmp

RUN apt update

# Устанавливаем Java JDK
RUN apt install -y default-jdk
RUN apt list | grep default-jdk >> /tmp/result
RUN echo '--------------------------' >> /tmp/result

# Устанавливаем Maven
RUN apt install -y maven
RUN apt list | grep "^maven"  >> /tmp/result
RUN echo '--------------------------' >> /tmp/result

# Устанавливаем Tomcat
#RUN apt install -y tomcat9
#RUN apt list | grep "^tomcat" >> /tmp/result
#RUN echo '--------------------------' >> /tmp/result

# Устанавливаем Git
RUN apt install -y git
RUN git --version >> /tmp/result
RUN echo '--------------------------' >> /tmp/result

# Скачиваем проект и компилим WAR
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /boxfuse-sample-java-war-hello
RUN mvn package
# Building war: /boxfuse-sample-java-war-hello/target/hello-1.0.war

