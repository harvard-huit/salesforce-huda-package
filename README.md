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

NOTE: You can see what orgs your sfdx environment is currently using with `sfdx org:list`. That will show your dev hub and any sandboxes or scratch orgs. 

1. Create a Dev Hub from a Developer org
  a. sign up for a developer org, these are free and unaffiliated with your other orgs
  b. turn on Dev Hub under settings -> Development -> Dev Hub
  c. wait like 20 minutes

2. Register the Namespace

This is only needed if the project uses a namespace -- the HUDA project does use the HUDA namespace. 
  a. log in to the Dev Hub Developer Org
  b. navigate to the Namespace Registry (this will only show if the Dev Hub is enabled and you've waited long enough)
  c. Link Namespace and log in to a registry holder, in this case it would be the `hudapackage1@harvard.edu` user and accept

3. Create a scratch org
  a. designate a dev hub
    ```
    sfdx org:login:web -d -a DevHub
    ```
    The dev hub should be a Developer Org. It can't be a sandbox. 

    Note: you can use `sfdx org:list` to see what you currently have available. You should see a `(D)` next to the Dev Hub you've logged in to.

  b. create a new local project (or use an existing one (like this project) and skip this)
    ```
    sfdx force:project:create -n "name of project"
    ```

  c. create scratch org
    ```
    sfdx org:create:scratch -f config/project-scratch-def.json -a MyScratchOrg
    ```

    Note: this can take 2-10 minutes
    
2. Generate a password (needed to install the EDA package)
    ```
    sfdx force:user:password:generate --targetusername <username to scratch org>
    ```
3. Install EDA by going here and logging in to your scratch org with the password you just created: [https://install.salesforce.org/products/eda/latest/install]

4. Install HUDA from your local to your scratch org:
    ```
    sfdx project:deploy:start --sourcepath . --targetusername test-h3t42txpg2ux@example.com
    ```
    This will move all of the meta data and create the objects/classes over as though it was installed.

    Or you can build the package and install that. 
    
    Building the package looks like: 
    ```

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
