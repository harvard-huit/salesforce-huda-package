# Salesforce DX Project: HUDA

## IMPORTANT NOTE

**This repository is defunct.** It was a failure of an exercise to convert the old HUDA into a newer version.

**The old HUDA is/was a First Generation Package.** 

 - It lives here: [https://d6a000001idiouaq-dev-ed.my.salesforce.com/]
 - The primary login name is (as of the writing of this): `hudapackage1@harvard.edu`
 - This is a "Packageing Org" but it also functions as the "Namespace Org"
   - **Packaging Orgs** are only needed for first generation packages
     - the "code" lives on the org
     - the package is cannot be converted into code
   - **Namespace Orgs** are needed for holding on to namespaces, such as **HUDA** or **HUD**, which are prefixes to all custom objects/classes/fields included in the package
     - this is expected to remain as the primary Namespace Org that we use moving forward
 - **As of the writing of this, there is no migration path for First Generation Packages into Second Generation Packages**

We will archive this repository, but keep it around as reference. Please see: [https://github.huit.harvard.edu/HUIT/salesforce-harvard-data-package] for the spiritual successor to this.


********************************** Begin Bad Documentation ********************************

(Don't believe everything you read.)

This repository should get you set up with being able to deploy the HUDA pacakge, version 3.0. This package relies on the (HUIT/salesforce-person-updates)[] project. 

## EDA No longer a Requirement

The old HUDA app requires EDA (Formerly HEDA). That was removed for this release. There may be consumers that still have EDA, if you want to install EDA to emulate one of those environments, EDA can be installed from the following: 
[https://install.salesforce.org/products/eda/latest/install]

 - Affiliation is the main thing we used from EDA. We funneled roles (employee/student/poi) into this object. The current version will create a different Affiliation object (in the HUDA) namespace that newer users can make use of. There is no plan currently create a migration process for that data as each instance has their own processes already built around that. 

## Old HUDA Install

In order to install the older version of HUDA (that this code comes from), use this package id: `04t3s000002zlI8` (`04t3s000002zlI8AAI`)

```
https://test.salesforce.com/packaging/installPackage.apexp?p0=04t3s000002zlI8
```
## Current HUDA Install

This version is available with the package ids associated with the release tags. 
```
https://test.salesforce.com/packaging/installPackage.apexp?p0=04tXXXXXXXXXXX
```

### Note on version IDs

In Salesforce, the key prefixes associated with packages differ based on the package type. The following are the key prefixes commonly used for Salesforce packages:

 - First-Generation Packages:
    - **033**: Unmanaged Package (First-Generation) 
    - **04t**: Managed Package (First-Generation)
 - Second-Generation Packages:
    - **0Ho**: Package Version ID (Second-Generation)



## Development Setup Steps

NOTE: This is a "second generation package", which generally means development and deployment are done through the sfdc-cli, available here: [https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm]

NOTE: You can see what orgs your sfdx environment is currently using with `sf org:list`. That will show your dev hub and any sandboxes or scratch orgs. 

### 1. Create a Dev Hub from a Developer org
  a. sign up for a developer org, these are free and unaffiliated with your other orgs
  b. turn on Dev Hub under settings -> Development -> Dev Hub
  c. wait like 20 minutes

### 2. Register the Namespace

This is only needed if the project uses a namespace -- the HUDA project does use the HUDA namespace. 
  a. log in to the Dev Hub Developer Org
  b. navigate to the Namespace Registry (this will only show if the Dev Hub is enabled and you've waited long enough)
  c. Link Namespace and log in to a registry holder, in this case it would be the `hudapackage1@harvard.edu` (or another linked account) user and accept

### 3. Create a scratch org
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
    sf org:create:scratch -f config/project-scratch-def.json -a HarvardDataScratch
    ```

    Note: this can take 2-10 minutes
    
### Generate or display a password 
    This may be needed to log into a scratch org, but is not strictly necessay. (`sf org:open` should also be usable for this)
    ```
    sf force:user:password:generate --target-org HarvardDataScratch
    ```

    You can also get the password if it exists with:
    ```
    sf org:display -target-org <username or alias of scratch org>
    ```

### 4. Install HUDA from your local to your scratch org:
    ```
    sf project:deploy:start --sourcepath . --targetusername <org username or alias>
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

#### Error with installing packages: `resource not found`

"Enable Unlocked Packages and Second-Generation Managed Packages" is an option under "enable dev hub" and must be selected for any package management to work from `sfdx`. An `sfdx` package is considered a 2nd gen managed package.



### 5. Create versioned package:
    A versioned package will push the package to a salesforce cloud location that can be retrieved by consumers with a link.

    ```
    sf package:version:create --path force-app --installation-key test1234 --wait 10 --target-dev-hub DevHub
    ```
    ```
    sf package:version:create --path force-app --installation-key-bypass --wait 10 --target-dev-hub DevHub
    ```



    NOTE: the installation key is a password added to the package so not anyone can install it. 

    This can then be installed using the link that is given to you, something like: 
    ```
    https://test.salesforce.com/packaging/installPackage.apexp?p0=04t3s000002zlI8
    ```


#### Create an unlocked package

You can also create an "unlocked" package. These are useful as they allow people to meddle with them. Deployed versions allow you to view and change the Apex code. They are not namespaced though. 

```
sf package:create --name HUDA --description "Huda Unlocked" --package-type Unlocked --path force-app --target-dev-hub DevHub
```

That package can then be seen by doing a `sf package:list` command and it can be deployed with:
```
sf package:install --package 0HoXXXXXXXXXXX --target-org HarvardDataScratch
```


#### Create a Managed package

A managed package created this way (without versioning it) will create a reference to a package that won't be available through Salesforce. It will need to be deployed through sfdx commands. (`sf package:install`)

```
sfdx package:create --name HUDA --description "Huda Managed" --path force-app --package-type Managed --target-dev-hub DevHub
```

#### Get the package id
```
sf package:list
```

## Dependencies

We're not using any dependencies currently, but if we need to add some in the future, this section exists. 

<!-- 
NO. This is not right:

If you have a dependency (like EDA), you need to retrieve the metadata for that dependency from an existing org and it needs to be in the source. 

 - Get the EDA metadata from an org that has it installed:
 ```
 sf project:retrieve:start --package-name EDA --target-org DevHub
 ```

 - Create a package from that metadata:
 ```
 sf package:create --name eda --description "EDA" --package-type Unlocked --path force-app --target-dev-hub DevHub
 ``` -->

If you don't have the package id, you can get the package id from an org:
```
sf package:installed:list --target-org DevHub
```

Then add the `04t` package id to the aliases in the project config, an example would be how the old HUDA looked: 

```
{
  "packageDirectories": [
    {
      "path": "force-app",
      "default": true,
      "package": "huda",
      "versionName": "v2.0",
      "versionNumber": "2.0.NEXT",
      "dependencies": [
        {
          "package": "EDA"
        }
      ]    
    }
  ],
  "name": "huda",
  "namespace": "HUDA",
  "sfdcLoginUrl": "https://login.salesforce.com",
  "sourceApiVersion": "57.0",
  "packageAliases": {
    "EDA": "04t1R0000016bHcQAI",
    "huda": "0HoDp000000fxZhKAI",
    "huda@2.0": "04t3s000002zlI8"
  }
}
```
The two parts that are important are:
 - the dependencies, with the package "name"
 - the package Aliases, that define the exact version id of the package


## Permset (if relevant)

TODO: come back to this!

```
sf force:user:permset:assign --perm-set-name huda
```



## Creating source from compiled package

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
