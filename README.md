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

### Setup steps

NOTE: You can see what orgs your sfdx environment is currently using with `sfdx force:org:list`. That will show your dev hub and any sandboxes or scratch orgs. 

1. Create a scratch org
  a. designate a dev hub
    ```
    auth:web:login -d -a DevHub
    ```
    The dev hub "needs to be a paid instance" and can't apparently be a sandbox, which is annoying. 
  b. create a new local project (or use an existing one and skip this)
    ```
    sfdx force:project:create -n "name of project"
    ```
  c. create scratch org
    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a MyScratchOrg
    ```
2. Generate a password (needed to install the EDA package)
    ```
    sfdx force:user:password:generate --targetusername <username to scratch org>
    ```
3. Install EDA by going here and logging in to your scratch org with the password you just created: [https://install.salesforce.org/products/eda/latest/install]

4. Install HUDA from your local to your scratch org:
    ```
    sfdx force:source:deploy --sourcepath . --targetusername test-h3t42txpg2ux@example.com
    ```

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
