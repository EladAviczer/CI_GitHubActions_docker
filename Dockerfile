FROM maven:3-jdk-8-alpine AS build
RUN addgroup -S appgroup && adduser -S zorki -G appgroup
USER zorki
ADD . /my-app
WORKDIR /my-app
RUN mvn versions:set -DnewVersion="1.0.1"
RUN mvn compile
RUN mvn package

FROM openjdk:8-jdk-alpine
RUN addgroup -S appgroup && adduser -S zorki -G appgroup
USER zorki
COPY --from=build /my-app/target/my-app-1.0.1.jar my-app-1.0.1.jar
ENTRYPOINT ["java" "-cp" "my-app-1.0.1.jar" "com.mycompany.app.App"]
