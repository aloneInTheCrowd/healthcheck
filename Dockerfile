FROM ubuntu:22.04

#ARG GRADLE_VERSION=8.8

# Install necessary packages
RUN apt-get update && apt-get install -y openjdk-21-jdk

WORKDIR /app

COPY gradle gradle
#COPY gradle.properties .
COPY build.gradle.kts .
COPY settings.gradle.kts .
COPY gradlew .

RUN ./gradlew --no-daemon dependencies

COPY src src

# COPY --from=frontend /frontend/dist /backend/src/main/resources/static

RUN ./gradlew --no-daemon build

#ENV JAVA_OPTS "-Xmx512M -Xms512M"
EXPOSE 8080

CMD java -jar build/libs/HealthCheck-0.0.1-SNAPSHOT.jar


