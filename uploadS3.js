const AWS = require('aws-sdk');
const fs = require('fs');

// Configure the AWS SDK
AWS.config.update({
    accessKeyId: 'ASIASMRWLBIMRX7EJDOC', // Replace with your AWS access key ID
    secretAccessKey: 'hyLRrpS3iCc9dKpaOLv+nEzTiavS4GWlXixVXaZ6', // Replace with your AWS secret access key
    region: 'ap-southeast-2', // Replace with your AWS region
});

// Create an S3 service object
const s3 = new AWS.S3();

// Specify the bucket name and the key (filename) under which to store the image
const bucketName = 'dummy';
const key = 'example.png'; // Replace 'your-key' with the desired key (filename) and extension

// Specify the path to the image file on your local machine
const filePath = '/Users/nataniathomas/Downloads/example.png';

// Read the image file from disk
const fileContent = fs.readFileSync(filePath);

// Upload the image file to the specified S3 bucket
s3.putObject({
    Bucket: bucketName,
    Key: key,
    Body: fileContent,
    ContentType: 'example.png' // Replace 'image/jpeg' with the appropriate content type if different
}, (err, data) => {
    if (err) {
        console.error(err);
    } else {
        console.log('Image uploaded successfully:', data);
    }
});
