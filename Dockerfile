FROM maven:3-jdk-8-alpine AS build
#RUN addgroup -S appgroup && adduser -S zorki -G appgroup
#USER zorki
RUN pwd
RUN ls
ADD . /my-app
WORKDIR /my-app
RUN pwd
RUN ls
ARG version
ENV VER ${version}
RUN echo ${VER}
ARG fullname="my-app-${version}"
RUN echo ${version}
#RUN mvn versions:set -DnewVersion="1.0.1"
RUN mvn compile
RUN mvn package

FROM openjdk:8-jdk-alpine
ARG fullname
RUN echo ${fullname}
ARG version
RUN echo ${version}
#RUN addgroup -S appgroup && adduser -S zorki -G appgroup
#USER zorki
#COPY --from=build /my-app/target/my-app-1.0.1.jar my-app-${VER}.jar
COPY --from=build /my-app/target/${fullname}.jar my-app-${version}.jar
RUN ls
ENTRYPOINT ["java" "-cp" "my-app-1.0.1.jar" "com.mycompany.app.App"]
