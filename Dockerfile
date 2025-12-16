FROM eclipse-temurin:8-jre-alpine

WORKDIR /usr/app

COPY target/java-maven-app-*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/usr/app/app.jar"]
