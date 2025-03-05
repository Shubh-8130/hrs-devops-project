#!/bin/bash

# Variables
REDIS_HOST="your-redis-endpoint"
REDIS_PORT=6379
S3_BUCKET="your-s3-bucket"
DUMP_FILE="/tmp/redis_dump.json"

# Ensure required dependencies are installed
if ! command -v redis-cli &> /dev/null; then
    echo "Installing redis-cli..."
    sudo apt update && sudo apt install -y redis-tools
fi

if ! command -v aws &> /dev/null; then
    echo "Installing AWS CLI..."
    sudo apt install -y awscli
fi

# Dump Redis data to JSON
echo "Fetching data from Redis..."
redis-cli -h $REDIS_HOST -p $REDIS_PORT --scan | while read key; do
    value=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT get "$key")
    echo "{\"key\": \"$key\", \"value\": \"$value\"}" >> $DUMP_FILE
done

# Upload to S3
if [[ -f "$DUMP_FILE" ]]; then
    echo "Uploading to S3..."
    aws s3 cp $DUMP_FILE s3://$S3_BUCKET/
    echo "Upload complete: s3://$S3_BUCKET/$(basename $DUMP_FILE)"
else
    echo "Error: Dump file not found!"
fi

# Cleanup
rm -f $DUMP_FILE
