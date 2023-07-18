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
    sfdx org:create:scratch -f config/project-scratch-def.json -a HarvardDataScratch
    ```

    Note: this can take 2-10 minutes
    
2. Generate a password (needed to install the EDA package)
    ```
    sfdx force:user:password:generate --target-org HarvardDataScratch
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


### Package up contents to deploy

#### Error with installing packages: `resource not found"

"Enable Unlocked Packages and Second-Generation Managed Packages" is an option under "enable dev hub" and must be selected for any package management to work from `sfdx`. An `sfdx` package is considered a 2nd gen managed package.


#### Create an unlocked package
```
sf package:create --name huda --description "Huda Test" --package-type Unlocked --path force-app --target-dev-hub DevHub
```

#### Create a Managed package

```
sfdx package:create --name huda --description "Huda 3.0 (Beta)" --path force-app --package-type Managed --target-dev-hub DevHub
```

#### Get the package id from the output of that or with 
```
sf package:list
```

#### Create a Package Version

Set up the `sfdx-package.json` file with `versionName` and `versionNumber` appropriately (`versionNumber` needs a `NEXT` to increment)
```
{
   "packageDirectories": [
      {
         "path": "force-app",
         "default": true,
         "package": "huda",
         "versionName": "v2.0",
         "versionNumber": "2.0.0.NEXT"
      }
   ],
   "namespace": "HUDA",
   "sfdcLoginUrl": "https://login.salesforce.com",
   "sourceApiVersion": "59",
   "packageAliases": {
      "huda": "0Hoxxx"
   }
}
```
Run this to create the versioned package
```
sf package:version:create --path force-app --installation-key test1234 --wait 10 --target-dev-hub DevHub
```

Deploy it (paying attention to the `@` value on the package)
```
sf package:install --wait 10 --publish-wait 10 --package huda@2.0.0-1 --installation-key test1234 --no-prompt
```

#### Permset (if relevant)

TODO: come back to this!

```
sf force:user:permset:assign --perm-set-name huda
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
