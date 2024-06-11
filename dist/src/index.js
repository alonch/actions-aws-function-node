exports.handler = async (event, context) => {
    console.log("hello world")
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "*/*"
        },
        "body": "hello world"
    }
}