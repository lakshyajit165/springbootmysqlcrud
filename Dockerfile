#stage -1  for volume mounting maven dependencies
FROM maven:3.6-jdk-8 AS build
COPY pom.xml .
RUN mvn -Dmaven.repo.local=$MVN_LOCAL_REPO dependency:go-offline
COPY src src
RUN mvn -Dmaven.repo.local=$MVN_LOCAL_REPO -f pom.xml clean package -DskipTests

#stage -2 for creating the image of the project
FROM openjdk:8
EXPOSE 8081
COPY --from=build /target/springsqlcrud-0.0.1-SNAPSHOT.jar springsqlcrud.jar
ENTRYPOINT ["java", "-jar", "/springsqlcrud.jar"]