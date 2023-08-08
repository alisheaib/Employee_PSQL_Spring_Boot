#
# Build stage
#
FROM maven:3.8.3-openjdk-17 AS build
WORKDIR /app
COPY . /app/
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM openjdk:17-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar /app/employee-management-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","employee-management-0.0.1-SNAPSHOT.jar"]