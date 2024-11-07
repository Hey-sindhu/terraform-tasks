#Base image
FROM ubuntu:22.04

#To run the commands 
RUN apt-get update && \
    apt-get install -y wget openjdk-17-jdk maven git 

#Working directory is to make default dir where I've pom.xml
WORKDIR /Amazon/Amazon

#To copy all the files from local to docker host system
COPY . .

RUN mvn clean install

#downloading tomcat and untaring the tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz && \
    tar -xzf apache-tomcat-9.0.96.tar.gz && \
    mv apache-tomcat-9.0.96 /usr/local/tomcat && \
    rm apache-tomcat-9.0.96.tar.gz

#Copying the war file to webapps 
RUN cp /Amazon/Amazon/Amazon-Web/target/Amazon.war /usr/local/tomcat/webapps/

# Exposing the port
EXPOSE 8085

# Start Tomcat
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/catalina.sh", "run"]
