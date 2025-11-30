FROM ubuntu:20.04

#COPY copywar.sh /tmp
#RUN chmod +x /tmp/copywar.sh

RUN apt update
RUN apt install -y net-tools

# Устанавливаем Java JDK
RUN apt install -y default-jdk

# Устанавливаем Maven
RUN apt install -y maven

# Устанавливаем Git
RUN apt install -y git

# Скачиваем проект и компилим WAR
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /boxfuse-sample-java-war-hello
RUN mvn package
# Building war: /boxfuse-sample-java-war-hello/target/hello-1.0.war

# Устанавливаем Tomcat
RUN apt-get install -y openjdk-11-jdk wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.34/bin/apache-tomcat-9.0.34.tar.gz
RUN tar -xzf apache-tomcat-9.0.34.tar.gz -C /opt/
RUN ln -s /opt/apache-tomcat-9.0.34 /opt/tomcat

EXPOSE 8080

#CMD ["/opt/tomcat/bin/startup.sh", "run"]
#CMD ["/opt/tomcat/bin/catalina.sh", "run"]
#**************************

#CMD ["/tmp/copywar.sh"]
# CMD /tmp/copywar.sh
#CMD ["sh", "-c", "/tmp/copywar.sh"]

# Путь к дериктории /opt/tomcat/webapps/
# или               /opt/apache-tomcat-9.0.34/webapps/
WORKDIR /boxfuse-sample-java-war-hello/target/
RUN pwd

RUN # Проверка исходной директории \
    if [ -d "/boxfuse-sample-java-war-hello/target" ]; then \
        echo "Директория /boxfuse-sample-java-war-hello/target/ существует" \
        ls -la /boxfuse-sample-java-war-hello/target/ >> /tmp/log.log \
    else  \
        echo "ОШИБКА: Директория /boxfuse-sample-java-war-hello/target/ не существует!" \
    fi

RUN # Проверка целевой директории \
    echo "Проверяем существование /opt/apache-tomcat-9.0.34/webapps/" \
    if [ -d "/opt/apache-tomcat-9.0.34/webapps" ]; then \
        echo "Директория /opt/apache-tomcat-9.0.34/webapps/ существует" \
    else \
        echo "ОШИБКА: директорию /opt/apache-tomcat-9.0.34/webapps/ не существует" \
        # Создание директории если нужно \
        # mkdir -p /destination >> $LOG_FILE 2>&1 \
    fi

RUN # Копирование файлов \
    echo "Начинаем копирование..." \
    cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /opt/apache-tomcat-9.0.34/webapps/

#CMD cp ./hello-1.0.war /opt/apache-tomcat-9.0.34/webapps/
#CMD cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /opt/apache-tomcat-9.0.34/webapps/
CMD ["/bin/bash"]
