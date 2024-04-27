/* Amplify Params - DO NOT EDIT
	API_INKAAPP_GRAPHQLAPIIDOUTPUT
	API_INKAAPP_TASKNOTESTABLE_ARN
	API_INKAAPP_TASKNOTESTABLE_NAME
	ENV
	FUNCTION_VIEWTASKNOTE_NAME
	REGION
Amplify Params - DO NOT EDIT */

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);
    return {
        statusCode: 200,
    //  Uncomment below to enable CORS requests
    //  headers: {
    //      "Access-Control-Allow-Origin": "*",
    //      "Access-Control-Allow-Headers": "*"
    //  },
        body: JSON.stringify('Hello from Lambda!'),
    };
};
