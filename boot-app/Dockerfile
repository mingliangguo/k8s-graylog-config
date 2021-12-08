FROM openjdk:8-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
EXPOSE 8080 8080
COPY build/libs/gs-spring-boot-docker-0.1.0.jar /app/lib/app.jar
ENTRYPOINT ["java","-jar","/app/lib/app.jar"]
