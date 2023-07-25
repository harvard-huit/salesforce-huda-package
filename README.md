# Salesforce DX Project: HUDA

This is a re-creation of the original HUDA 2.0. Built from the package. This repository should get you set up with being able to deploy the Winter 2020 release (2.0.0.1).

## EDA Requirement

Currently the HUDA app requires EDA (Formerly HEDA). 

EDA can be installed from the following: 
[https://install.salesforce.org/products/eda/latest/install]

However, it should be noted that EDA is deprecated and nearing end of life. So the future of this should not rely on that. 

### EDA Dependancies

 - Affiliation is the main thing we use from EDA. We funnel roles (employee/student/poi) into this object. 

## HUDA Install

In order to install the older version of HUDA (that this code comes from), use this package id: `04t3s000002zlI8`

```
https://test.salesforce.com/packaging/installPackage.apexp?p0=04t3s000002zlI8
```

### Development Setup Steps

NOTE: This is a "second generation package", which generally means development and deployment are done through the sfdc-cli, available here: [https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm]

NOTE: You can see what orgs your sfdx environment is currently using with `sf org:list`. That will show your dev hub and any sandboxes or scratch orgs. 

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
    sf force:user:password:generate --targetusername <username to scratch org>
    ```

    You can also get the password if it exists with:
    ```
    sf org:display -target-org <username or alias of scratch org>
    ```

3. Install EDA by going here and logging in to your scratch org with the password you just created: [https://install.salesforce.org/products/eda/latest/install]

4. Install HUDA from your local to your scratch org:
    ```
    sf project:deploy:start --sourcepath . --targetusername test-h3t42txpg2ux@example.com
    ```
    This will move all of the meta data and create the objects/classes over as though it was installed. 

    This is the way things get compiled, you'll get the compile errors from doing this and be able to debug (if there are any). 

    You can check what packages are installed in the org with this command:
    ```
    sf package:installed:list --target-org HarvardDataScratch
    ```

    You may need to delete the existing huda due to conflicts. This is best done through the Salesforce interface, settings -> installed packages, but you can use:
    ```
    sf package:uninstall --target-org HarvardDataScratch --pacakge <package id>
    ```


5. Create versioned package:
    A versioned package will push the package to a salesforce cloud location that can be retrieved by consumers with a link.

    ```
    sf package:version:create --path force-app --installation-key test1234 --wait 10 --target-dev-hub DevHub
    ```

    NOTE: the installation key is a password added to the package so not anyone can install it.

    This can then be installed using the link that is given to you, something like: 
    ```
    https://test.salesforce.com/packaging/installPackage.apexp?p0=04t3s000002zlI8
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
