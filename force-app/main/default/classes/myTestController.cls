public with sharing class myTestController {
    
    public PageReference emailUpdate() {
        HUDEmailsUpdateByContacts myObj = new HUDEmailsUpdateByContacts();
        integer myCount = myObj.runUpdate();
        String myPage = '/apex/ConfirmationOfHUDUpdate?myObject=email&myCount=' + myCount;
        PageReference pageRef = new PageReference(myPage);
        return pageRef;
    }
    
    public PageReference addressUpdate() {
        HUDAddressesUpdateByContacts myObj = new HUDAddressesUpdateByContacts();
        integer myCount = myObj.runUpdate();
        String myPage = '/apex/ConfirmationOfHUDUpdate?myObject=address&myCount=' + myCount;
        PageReference pageRef = new PageReference(myPage);
        //PageReference pageRef = new PageReference('/apex/ConfirmationOfHUDUpdate');
        return pageRef;
    }
    
     public PageReference nameUpdate() {
        HUDNamesUpdateByContacts myObj = new HUDNamesUpdateByContacts();
        integer myCount = myObj.runUpdate();
        String myPage = '/apex/ConfirmationOfHUDUpdate?myObject=name&myCount=' + myCount;
        PageReference pageRef = new PageReference(myPage);
        //PageReference pageRef = new PageReference('/apex/ConfirmationOfHUDUpdate');
        return pageRef;
    }
   
    
    public PageReference locationUpdate() {
        HUDLocationsUpdateByContacts myObj = new HUDLocationsUpdateByContacts();
        integer myCount = myObj.runUpdate();
        String myPage = '/apex/ConfirmationOfHUDUpdate?myObject=location&myCount=' + myCount;
        PageReference pageRef = new PageReference(myPage);
        //PageReference pageRef = new PageReference('/apex/ConfirmationOfHUDUpdate');
        return pageRef;
    }
    
     public PageReference phoneUpdate() {
        HUDPhonesUpdateByContacts myObj = new HUDPhonesUpdateByContacts();
        integer myCount = myObj.runUpdate();
        String myPage = '/apex/ConfirmationOfHUDUpdate?myObject=phone&myCount=' + myCount;
        PageReference pageRef = new PageReference(myPage);
        //PageReference pageRef = new PageReference('/apex/ConfirmationOfHUDUpdate');
        return pageRef;
    }    
   
   
    
    public PageReference affiliationUpdateContact() {
        HED_AffiliationsUpdateByContacts myObj = new HED_AffiliationsUpdateByContacts();
        integer myCount = myObj.runUpdate();
        String myPage = '/apex/ConfirmationOfHUDUpdate?myObject=affilliation&myCount=' + myCount;
        PageReference pageRef = new PageReference(myPage);
        return pageRef;
    }
    
    
  

    public myTestController()
    {
         
    }
  
  
}