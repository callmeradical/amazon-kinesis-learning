FROM maven:3.8.3-openjdk-17 as compiler

COPY . /usr/src/app
WORKDIR /usr/src/app
RUN rm -rf target
RUN mvn clean install


FROM openjdk:17-jdk-alpine3.14 as writer 
RUN mkdir -p /usr/src/app/target
WORKDIR /usr/src/app/target
COPY --from=compiler /usr/src/app/target/amazon-kinesis-learning-0.0.1.jar .
COPY --from=compiler /usr/src/app/deploy/exec.sh .
RUN chmod +x exec.sh
ENTRYPOINT [ "./exec.sh" ]