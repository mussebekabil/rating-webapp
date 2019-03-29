#!/bin/bash
# Azure Storage script

export AZURE_STORAGE_ACCOUNT=<storageaccountname>
export AZURE_STORAGE_KEY=<storageaccountkey>
export container_name=linkedtemplatecontainer

echo "Creating the container..."
az storage container create --name $container_name

echo "Clone templates from git ..." 
git clone https://github.com/mussebekabil/rating-webapp.git ~/clouddrive/templates

echo "Clean up unnecessary files ..." 
rm -rf ~/clouddrive/templates/.git && rm ~/clouddrive/templates/.gitignore

echo "Uploading the file..."
az storage blob upload-batch -s ~/clouddrive/templates -d $container_name 

echo "Clean up working directory ..." 
rm -rf ~/clouddrive/templates

echo "Listing the blobs..."
az storage blob list --container-name $container_name --output table

echo "Done"
