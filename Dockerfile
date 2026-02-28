FROM eclipse-temurin:17-jre
WORKDIR /app
COPY target/*.jar app.jar
ENTRYPOINT ["java","-cp","/app/app.jar","com.wlopez.App"]
