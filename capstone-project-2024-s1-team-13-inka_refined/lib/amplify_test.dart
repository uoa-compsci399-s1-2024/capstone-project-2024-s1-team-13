class AmplifyConfiguration {
  static const String awsConfig = '''
  {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
      "plugins": {
        "awsCognitoAuthPlugin": {
          "UserPoolId": "ap-southeast-2_t5yFisdBr",
          "Region": "ap-southeast-2"
        }
      }
    }
  }
  ''';
}
