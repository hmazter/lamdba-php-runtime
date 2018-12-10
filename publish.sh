#!/bin/bash -e

regions=eu-west-1

for region in ${regions}; do
  echo "Publishing Lambda Layer php71 in region ${region}..."
  version=$(aws --region ${region} lambda publish-layer-version --layer-name php71 --zip-file fileb://php71.zip --output text --query Version)
  echo "Published Lambda Layer php71 in region ${region} version ${version}"

  #echo "Setting public permissions on Lambda Layer php71 version ${version} in region ${region}..."
  #aws --region $region lambda add-layer-version-permission --layer-name php71 --version-number $version --statement-id=public --action lambda:GetLayerVersion --principal '*' > /dev/null
  #echo "Public permissions set on Lambda Layer php71 version ${version} in region ${region}"
done
