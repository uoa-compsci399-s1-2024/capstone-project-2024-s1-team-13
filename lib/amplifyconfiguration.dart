const amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "inkateam13capstone": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://xbrjpsso7vclnbvohvaqjf6jmy.appsync-api.ap-southeast-2.amazonaws.com/graphql",
                    "region": "ap-southeast-2",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-vg5qxcjdtfc3phsla5p2uaagia"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://xbrjpsso7vclnbvohvaqjf6jmy.appsync-api.ap-southeast-2.amazonaws.com/graphql",
                        "Region": "ap-southeast-2",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-vg5qxcjdtfc3phsla5p2uaagia",
                        "ClientDatabasePrefix": "inkateam13capstone_API_KEY"
                    },
                    "inkateam13capstone_AWS_IAM": {
                        "ApiUrl": "https://xbrjpsso7vclnbvohvaqjf6jmy.appsync-api.ap-southeast-2.amazonaws.com/graphql",
                        "Region": "ap-southeast-2",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "inkateam13capstone_AWS_IAM"
                    },
                    "inkateam13capstone_API_KEY": {
                        "ApiUrl": "https://xbrjpsso7vclnbvohvaqjf6jmy.appsync-api.ap-southeast-2.amazonaws.com/graphql",
                        "Region": "ap-southeast-2",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-vg5qxcjdtfc3phsla5p2uaagia",
                        "ClientDatabasePrefix": "inkateam13capstone_API_KEY"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-southeast-2:23cf7004-b692-4fae-acda-ec15155a3a3f",
                            "Region": "ap-southeast-2"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-southeast-2_Kk5N3jjUK",
                        "AppClientId": "4vtpidukbhbib6md2kibcc9t6j",
                        "Region": "ap-southeast-2"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "socialProviders": [],
                        "usernameAttributes": [],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                }
            }
        }
    }
}''';
