# Use an official Maven image to build the application
FROM maven:3.9.5-eclipse-temurin-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files (pom.xml and source code)
COPY pom.xml .
COPY src ./src

# Build the project and create the JAR file
RUN mvn clean package -DskipTests

# Use a smaller JRE image for the runtime environment
FROM eclipse-temurin:17-jre

# Set the working directory for the runtime container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/UnitTest-1.0-SNAPSHOT.jar /app/TimeCalculator.jar

# Specify the command to run the application
ENTRYPOINT ["java", "-jar", "/app/TimeCalculator.jar"]
