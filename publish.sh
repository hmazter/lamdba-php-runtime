#!/bin/bash -e

regions=eu-west-1

for region in ${regions}; do
  echo "Publishing Lambda Layer php72 in region ${region}..."
  version=$(aws --region ${region} lambda publish-layer-version --layer-name php72 --zip-file fileb://php72.zip --output text --query LayerVersionArn)
  echo "Published Lambda Layer php72 in region ${region}, Layer ARN: ${version}"

  #echo "Setting public permissions on Lambda Layer php72 version ${version} in region ${region}..."
  #aws --region $region lambda add-layer-version-permission --layer-name php72 --version-number $version --statement-id=public --action lambda:GetLayerVersion --principal '*' > /dev/null
  #echo "Public permissions set on Lambda Layer php72 version ${version} in region ${region}"
done
