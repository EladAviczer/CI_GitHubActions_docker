FROM maven:3-jdk-8-alpine AS build
RUN groupadd -gid 1000 nogodmod && useradd --uid 1000 --gid nogodmod --shell /bin/bash --create-home node
USER rafa
ADD . /my-app
WORKDIR /my-app
RUN mvn versions:set -DnewVersion="1.0.1"
RUN mvn compile
RUN mvn package


RUN groupadd -r rafa && useradd --no-log-init -r -g rafa rafa
RUN useradd rafa
USER rafa
COPY --from=build /my-app/target/my-app-1.0.1.jar my-app-1.0.1.jar
ENTRYPOINT ["java" "-cp" "my-app-1.0.1.jar" "com.mycompany.app.App"]
