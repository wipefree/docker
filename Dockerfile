FROM ubuntu:20.04
LABEL authors="Andre"

#ENTRYPOINT ["top", "-b"]

RUN apt update

# Устанавливаем Java JDK
RUN apt install -y default-jdk
RUN apt list | grep default-jdk >> /tmp/result
RUN echo '--------------------------' >> /tmp/result
