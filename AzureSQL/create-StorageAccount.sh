#!/bin/bash

ResourceGroup="SQL"
AzureSQL="WoodDB"
StorageAccount="woodsqlstoragetest"
location="westeurope"


az storage account create \
    --name $StorageAccount \
    --resource-group $ResourceGroup \
    --location $location \
    --sku Standard_LRS \
    --encryption blob

az storage account keys list \
    --account-name $StorageAccount \
    --resource-group $ResourceGroup \
    --output table
