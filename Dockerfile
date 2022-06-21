FROM maven:3.6.0-jdk-11-slim AS build
#RUN useradd -u 8877 rafa
#USER rafa
ADD my-app /home/my-app
WORKDIR /home/my-app
#RUN mvn versions:set -DnewVersion="1.0.1"
RUN mvn compile -X
RUN mvn package


FROM openjdk:11-jre-slim
#RUN useradd -u 8877 rafa
#USER rafa
COPY --from=build /home/app/target/my-app-1.0.1.jar my-app-1.0.1.jar
ENTRYPOINT ["java" "-cp" "my-app-1.0.1.jar" "com.mycompany.app.App"]