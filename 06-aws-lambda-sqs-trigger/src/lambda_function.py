def lambda_handler(event, context):
    print("Message received from SQS")
    for record in event['Records']:
        print(f"Message body: {record['body']}")
    return {
        'statusCode': 200,
        'body': 'Message processed successfully'
    }
