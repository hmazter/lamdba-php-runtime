AWS Lambda PHP Runtime
======================

Custom PHP 7.1 runtime for AWS Lambda, packaged as a Layer.

THis is very much a pre-alpha and mostly done to test out the runtime/layer feature.
If you want anything production ready to tun PHP, you should probably look at [Bref](https://github.com/mnapoli/bref) 
or the [semi-official PHP layer by Stackery](https://github.com/stackery/php-lambda-layer)

## Getting started

Before starting, you need these dependencies on your computer:
* [Docker](https://www.docker.com/get-started) 
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* [AWS SAM CLI](https://github.com/awslabs/aws-sam-cli/blob/develop/docs/installation.rst)

1. Clone repository `git clone git@github.com:hmazter/lambda-php-runtime.git`
1. `cd lambda-php-runtime`
1. Build the layer `make`
1. Publish the layer `make publish`, this will output the layer arn that you then can reference in your SAM template etc


## SAM Example

**Create a SAM template called `template.yaml with the following content:**
```yml
AWSTemplateFormatVersion: 2010-09-09
Description: Hello world with provided runtime
Transform: AWS::Serverless-2016-10-31
Resources:
  HelloWorld:
    Type: AWS::Serverless::Function
    Properties:
      FunctionName: HelloWorld
      Description: Hello world
      CodeUri: hello-world
      Runtime: provided
      Handler: index.php
      MemorySize: 128
      Timeout: 30
      Tracing: Active
      Layers:
        - arn:aws:lambda:eu-west-1:338711535985:layer:php71:10 # replace this with your ARN from the "make publish" output
```

**Create a file called `hello-world/index.php` with this content:**
```php
<?php

$payload = $argv[1];

echo "Echoing payload: $payload";
```

You should now have the following structure:
``` 
.
├── template.yaml
└── hello-world
    └── index.php
```

### Deploy Function
You need a S3 Bucket for deployment packages [as described here](https://github.com/awslabs/aws-sam-cli/blob/develop/docs/deploying_serverless_applications.rst#packaging-your-application)

```bash
$ sam package \
    --template-file template.yaml \
    --output-template-file packaged.yaml \
    --s3-bucket <your SAM deployment bucket>

$ sam deploy \
    --template-file packaged.yaml \
    --stack-name my-first-serverless-php-service \
    --capabilities CAPABILITY_IAM
```

### Run it locally
To test this locally you can use SAM CLI

Start a local instance of Lambda with:
```bash
sam local start-lambda
```

And in another terminal, run this to trigger a event:
```bash
echo '{"message:": "Hello World"}' | sam local invoke HelloWorld
```