# Use Maven to build the app
FROM maven:3.8.5-openjdk-8-slim AS build

WORKDIR /app

# Copy project files
#COPY pom.xml .
#COPY src ./src

# Build the jar (skipping tests)
RUN mvn clean package -DskipTests

# Use a lightweight JDK image to run the app
FROM openjdk:8-jdk-alpine

WORKDIR /app

# Copy the jar from the build stage (replace with your jar name)
COPY --from=build /app/target/springoauth2-0.0.1-SNAPSHOT.jar app.jar

# Expose the port (Render sets the actual port via PORT env var)
EXPOSE 8080

# Run the app with dynamic port binding
CMD ["sh", "-c", "java -jar app.jar --server.port=$PORT"]
