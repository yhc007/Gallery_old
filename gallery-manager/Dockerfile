FROM tomcat:10.1.0-jdk11-openjdk
ARG WAR_FILE=build/libs/ROOT.war
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
ENTRYPOINT ["java","-jar","/usr/local/tomcat/webapps/ROOT.war"]
