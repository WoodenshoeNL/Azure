#!/bin/bash

location="westeurope"
ResourceGroup="WoodSpark"
vNet="Spark-Vnet"
subNet="Spark-Subnet"
vNetRange="10.12.0.0/16"
subNetRange="10.12.0.0/24"


#Create Resource Group

az group create --name $ResourceGroup --location $location


#Create VNet

az network vnet create \
    --resource-group $ResourceGroup \
    --name $vNet \
    --address-prefix $vNetRange \
    --subnet-name $subNet \
    --subnet-prefix $subNetRange


#Create PIP's

az network public-ip create \
    --resource-group $ResourceGroup \
    -n SparkPip

#Create NSG
az network nsg create \
    --resource-group $ResourceGroup \
    -n Spark-nsg

#Attache NSG to Subnet
az network vnet subnet update \
    --resource-group $ResourceGroup \
    --subnet $subNet \
    --vnet-name $vNet \
    --network-security-group Spark-nsg

#Create SSH NSG rule
az network nsg rule create \
    --resource-group $ResourceGroup \
    -n kubernetes-allow-ssh \
    --access allow \
    --destination-address-prefix '*' \
    --destination-port-range 22 \
    --direction inbound \
    --nsg-name Spark-nsg \
    --protocol tcp \
    --source-address-prefix '*' \
    --source-port-range '*' \
    --priority 1000


#Create NIC's

az network nic create \
    --resource-group $ResourceGroup \
    --vnet-name $vNet \
    --subnet $subNet \
    -n SparkNic \
    --public-ip-address SparkPip



#Create Master Node:

az vm create \
    --resource-group $ResourceGroup \
    --name Spark01 \
    --image UbuntuLTS \
    --admin-username michel \
    --generate-ssh-keys \
    --size Standard_D2_v3 \
    --nics SparkNic
