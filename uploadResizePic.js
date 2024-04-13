const AWS = require('aws-sdk');
const sharp = require('sharp');

const s3 = new AWS.S3();

exports.handler = async (event) => {
    const bucket = event.Records[0].s3.bucket.name;
    const key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' '));
    
    try {
        // Get the uploaded image from S3
        const params = {
            Bucket: bucket,
            Key: key
        };
        const { Body } = await s3.getObject(params).promise();
        
        // Resize the image
        const resizedImage = await sharp(Body)
            .resize({ width: 300, height: 300 })
            .toBuffer();
        
        // Upload the resized image back to S3
        const newKey = key.replace('uploads/', 'resized/');
        const uploadParams = {
            Bucket: bucket,
            Key: newKey,
            Body: resizedImage,
            ContentType: 'image/jpeg' // Change this based on the image type
        };
        await s3.putObject(uploadParams).promise();
        
        return {
            statusCode: 200,
            body: JSON.stringify('Image resized and uploaded successfully'),
        };
    } catch (error) {
        console.error('Error:', error);
        return {
            statusCode: 500,
            body: JSON.stringify('Error resizing image'),
        };
    }
};
