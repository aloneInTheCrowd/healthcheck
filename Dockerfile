FROM eclipse-temurin:21-jdk-jammy AS builder
WORKDIR /app
COPY gradle gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .
COPY gradlew .
RUN ./gradlew --no-daemon dependencies

COPY src src
RUN ./gradlew --no-daemon build

FROM eclipse-temurin:21-jre-jammy AS runner
WORKDIR /app
EXPOSE 8000
COPY --from=builder /app/build/libs/HealthCheck-0.0.1-SNAPSHOT.jar /app/build/libs/HealthCheck-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "build/libs/HealthCheck-0.0.1-SNAPSHOT.jar", "--server.port=8000"]
