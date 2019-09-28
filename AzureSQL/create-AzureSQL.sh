#!/bin/bash

ResourceGroup="SQL"
AzureSQL="WoodDB"
location="westeurope"

adminlogin=SqlAdmin
password=`openssl rand -base64 16`
# password=<EnterYourComplexPasswordHere1>

servername=$AzureSQL-server

startip=0.0.0.0
endip=0.0.0.0

homeStart="31.201.214.198"
homeEnd="31.201.214.198"

az sql server create \
    --name $servername \
    --resource-group $ResourceGroup \
    --location $location  \
    --admin-user $adminlogin \
    --admin-password $password

az sql server firewall-rule create \
    --resource-group $ResourceGroup \
    --server $servername \
    -n AllowAzureServices \
    --start-ip-address $startip \
    --end-ip-address $endip

az sql server firewall-rule create \
    --resource-group $ResourceGroup \
    --server $servername \
    -n AllowHome \
    --start-ip-address $homeStart \
    --end-ip-address $homeEnd

az sql db create \
    --resource-group $ResourceGroup \
    --server $servername \
    --name mySampleDatabase \
    --sample-name AdventureWorksLT \
    --edition GeneralPurpose \
    --family Gen4 \
    --capacity 1 \
    --zone-redundant false

# Echo random password
echo $password
