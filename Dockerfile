FROM ubuntu:20.04
LABEL authors="Andre"
#ENTRYPOINT ["top", "-b"]

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

# Устанавливаем Git
RUN apt install -y git
RUN git --version >> /tmp/result
RUN echo '--------------------------' >> /tmp/result

# Скачиваем проект и компилим WAR
RUN cd ..
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN cd boxfuse-sample-java-war-hello
RUN mvn package

