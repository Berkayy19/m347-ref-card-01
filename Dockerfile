# Stage 1: Build the application mit Java 21
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Baut das Projekt und überspringt Tests in dieser Phase
RUN mvn clean package -DskipTests

# Stage 2: Run the application mit Java 21
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Kopiert das fertige .jar File aus der Build-Stage
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]