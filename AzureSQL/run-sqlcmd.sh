#!/bin/bash

sqlServer="wooddb-server.database.windows.net"
adminAccount="SqlAdmin"
password=""
database="mySampleDatabase"

sqlcmd -S $sqlServer -U $adminAccount -P $password -d $database
