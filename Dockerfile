# Stage 1: Build the Java app using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set the working directory
WORKDIR /app

# Copy all project files
COPY . .

# Build the project and create the JAR file
RUN mvn clean package

# Stage 2: Run the app using a minimal JRE image
FROM eclipse-temurin:17-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/java-sample-app-1.0-SNAPSHOT.jar app.jar

# Set the entry point
ENTRYPOINT ["java", "-jar", "app.jar"]

