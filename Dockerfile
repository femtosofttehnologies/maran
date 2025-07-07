FROM maven:3.8.5-openjdk-8-slim AS build

WORKDIR /app

COPY maran/pom.xml .
COPY maran/src ./src

RUN mvn clean package -DskipTests

FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/<your-jar-name>.jar app.jar

EXPOSE 8080

CMD ["sh", "-c", "java -jar app.jar --server.port=${PORT}"]
