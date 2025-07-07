# ----- Stage 1: Build using Maven -----
FROM maven:3.8.5-openjdk-8-slim AS build

WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Build the JAR (skip tests for faster build)
RUN mvn clean package -DskipTests

# ----- Stage 2: Run the Spring Boot App -----
FROM openjdk:8-jdk-alpine

WORKDIR /app

# Copy built JAR from previous stage
COPY --from=build /app/target/springoauth2.jar app.jar

# Expose port Render provides
EXPOSE 8080

# Run the app with Render's dynamic PORT
CMD ["sh", "-c", "java -jar app.jar --server.port=${PORT}"]
