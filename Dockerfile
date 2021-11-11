FROM maven:3.8.3-openjdk-17 as compiler

COPY . /usr/src/app
WORKDIR /usr/src/app
RUN rm -rf target
RUN mvn clean install


FROM openjdk:17-jdk-alpine3.14 as writer 
RUN mkdir -p /usr/src/app/target
WORKDIR /usr/src/app/target
COPY --from=compiler /usr/src/app/target/amazon-kinesis-learning-0.0.1.jar .
ENV JAVA_CLASS="com.amazonaws.services.kinesis.samples.stocktrades.writer.StockTradesWriter"
ENV KINESIS_STREAM="StockTradeStream"
ENV REGION="us-east-1"
ENV JAR="amazon-kinesis-learning-0.0.1.jar"
ENV cmd="java -cp $JAR $JAVA_CLASS $KINESIS_STREAM $REGION"
RUN echo $cmd > writer_cmd.sh
RUN chmod +x writer_cmd.sh
ENV JAVA_CLASS="com.amazonaws.services.kinesis.samples.stocktrades.processor.StockTradesProcessor"
ENV cmd="java -cp $JAR $JAVA_CLASS StockTradesProcessor $KINESIS_STREAM $REGION"
RUN echo $cmd > processor_cmd.sh
RUN chmod +x processor_cmd.sh