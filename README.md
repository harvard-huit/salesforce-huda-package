# Salesforce DX Project: HUDA

This is a re-creation of the original HUDA 2.0. Built from the package. 

## EDA Requirement

Currently the HUDA app requires EDA (Formerly HEDA). 

EDA can be installed from the following: 
[https://install.salesforce.org/products/eda/latest/install]

However, it should be noted that EDA is deprecated and nearing end of life. So the future of this should not rely on that. 

### EDA Dependancies

 - Affiliation is the main thing we use from EDA. We funnel roles (employee/student/poi) into this object. 

## HUDA Install

In order to install the older version of HUDA (that this code comes from), use this package id: `04t3s000002zlI8`

### Creating source from compiled package

I didn't have access to the package in source form, so I used these commands to build the source from the package.

1. Create a new Salesforce DX project
```
sfdx force:project:create -n huda
```
2. Export the package from an installed instance
```
sfdx force:mdapi:retrieve -s -r ../mdapipkg -u jazahn@brave-hawk-mo9fve.com -p HUDA
```
3. Unzip the downloaded zip
```
cd ../mdapipkg
unzip unpackaged.zip 
```
4. Convert the package into Salesforce DX
```
cd ../huda
sfdx force:mdapi:convert --rootdir ../mdapipkg --outputdir .
```
