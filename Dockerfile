FROM openjdk:latest

WORKDIR /app

COPY . /app

RUN chmod +x ./mvnw

RUN ./mvnw clean install -DskipTests

EXPOSE 8080

CMD ["java", "-jar", "/app/.mvn/wrapper/maven-wrapper.jar"]
