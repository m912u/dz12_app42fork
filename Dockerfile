FROM docker as buildfarm
RUN apk --no-cache add maven curl git openjdk11
WORKDIR /tmp/src/project/
COPY . /tmp/src/project/
RUN mvn package

FROM tomcat
COPY --from=buildfarm /tmp/src/project/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
