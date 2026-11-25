FROM eclipse-temurin:21.0.13.1_2-jre-noble
#创建并进入工作目录/app
WORKDIR /app	
COPY target/web-demo.jar app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]