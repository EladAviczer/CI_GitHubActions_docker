FROM maven:3-jdk-8-alpine AS build
#RUN addgroup -S appgroup && adduser -S zorki -G appgroup
#USER zorki
ADD . /my-app
WORKDIR /my-app
ARG version
ENV VER ${version}
RUN echo ${VER}
ARG fullname="my-app-${version}"
RUN echo ${version}
RUN mvn compile
RUN mvn package

FROM openjdk:8-jdk-alpine
ARG fullname
RUN echo ${fullname}
ARG version
RUN echo ${version}

RUN addgroup -S appgroup && adduser -S zorki -G appgroup
USER zorki
COPY --from=build /my-app/target/${fullname}.jar ${fullname}.jar
#COPY --from=build /my-app/target/my-app-${version}.jar my-app-${version}.jar
CMD exec java -cp ${fullname}.jar com.mycompany.app.App
