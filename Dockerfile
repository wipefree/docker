FROM ubuntu:20.04

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

# Путь к дериктории /opt/tomcat/webapps/
# или               /opt/apache-tomcat-9.0.34/webapps/
WORKDIR /boxfuse-sample-java-war-hello/target/
CMD cp ./hello-1.0.war /opt/apache-tomcat-9.0.34/webapps/
#CMD cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /opt/apache-tomcat-9.0.34/webapps/

#CMD ["/opt/tomcat/bin/startup.sh", "run"]
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
#**************************************************************************
#CMD ["/bin/bash"]
