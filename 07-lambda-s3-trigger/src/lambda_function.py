def lambda_handler(event, context):
    print("S3 File Uploaded. Hooray!")
    return {
        'statusCode': 200,
        'body': 'File upload processed successfully'
    }
