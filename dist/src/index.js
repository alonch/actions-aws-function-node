exports.handler = async (event, context) => {
    console.log(event)
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "*/*"
        },
        "body": "hello world"
    }
}