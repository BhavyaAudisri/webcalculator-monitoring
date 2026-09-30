# Stage 1 - Build
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package

# Stage 2 - Runtime
FROM eclipse-temurin:17

WORKDIR /app

ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.122/bin/apache-tomcat-9.0.122.tar.gz /app/

RUN tar -xzf apache-tomcat-9.0.122.tar.gz && \
    mv apache-tomcat-9.0.122 tomcat

COPY --from=builder /app/target/*.war /app/tomcat/webapps/

EXPOSE 8080

CMD ["/app/tomcat/bin/catalina.sh", "run"]
