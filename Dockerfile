FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom.xml first to cache dependencies
COPY pom.xml .
RUN mvn -q -B -DskipTests dependency:go-offline

# Copy the entire project (not just src)
COPY . .

# Package the Spring Boot app
RUN mvn -q -B -DskipTests package

# Expose Spring Boot app port (9090)
EXPOSE 9090

# Multi stagte build dockerhg
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
