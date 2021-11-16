#! /bin/sh
set -e

KINESIS_STREAM="StockTradeStream"
REGION="us-east-1"
JAR="amazon-kinesis-learning-0.0.1.jar"

if [ "$1" = "write" ]; then
    JAVA_CLASS="com.amazonaws.services.kinesis.samples.stocktrades.writer.StockTradesWriter"
    echo "Write command provided..."
    CMD="java -cp $JAR $JAVA_CLASS $KINESIS_STREAM $REGION"

elif [ "$1" = "process" ]; then
    JAVA_CLASS="com.amazonaws.services.kinesis.samples.stocktrades.processor.StockTradesProcessor"
    echo "Process command provided..."
    CMD="java -cp $JAR $JAVA_CLASS StockTradesProcessor $KINESIS_STREAM $REGION"
else
    echo "Command supplied must be one of write or process."
fi

exec $CMD