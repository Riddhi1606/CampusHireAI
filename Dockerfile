FROM tomcat:9.0-jdk17-corretto

# Clear default webapps
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Download JSTL libraries directly into Tomcat lib folder
ADD https://repo1.maven.org/maven2/javax/servlet/jsp/jstl/jstl-api/1.2/jstl-api-1.2.jar /usr/local/tomcat/lib/
ADD https://repo1.maven.org/maven2/org/glassfish/web/jstl/1.2/jstl-1.2.jar /usr/local/tomcat/lib/

# Copy WAR file as ROOT
COPY CampusHireAI.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
