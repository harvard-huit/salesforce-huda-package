public with sharing class myTestForBatchController {
    
    
    public PageReference emailUpdate() {
        HUDEmailsUpdateByContactsBatch myObj = new HUDEmailsUpdateByContactsBatch();
        myObj.email='testBatch@harvard.edu';
        ID batchprocessid = Database.executeBatch(myObj);
        String myPage = '/apex/ConfirmationOfHUDUpdateForBatch?myObject=email&myCount=' + batchprocessid;
        PageReference pageRef = new PageReference(myPage);
        return pageRef;
    }
    
     public PageReference addressUpdate() {
        HUDAddressesUpdateByContactsBatch myObj = new HUDAddressesUpdateByContactsBatch();
        myObj.email='testBatch@harvard.edu';
        ID batchprocessid = Database.executeBatch(myObj);
        String myPage = '/apex/ConfirmationOfHUDUpdateForBatch?myObject=address&myCount=' + batchprocessid;
        PageReference pageRef = new PageReference(myPage);
        return pageRef;
    }
    
    public PageReference nameUpdate() {
        HUDNamesUpdateByContactsBatch myObj = new HUDNamesUpdateByContactsBatch();
        myObj.email='testBatch@harvard.edu';
        ID batchprocessid = Database.executeBatch(myObj);
        String myPage = '/apex/ConfirmationOfHUDUpdateForBatch?myObject=name&myCount=' + batchprocessid;
        PageReference pageRef = new PageReference(myPage);
        return pageRef;
    }

    
    
   
    
    public PageReference locationUpdate() {
        HUDLocationsUpdateByContactsBatch myObj = new HUDLocationsUpdateByContactsBatch();
         myObj.email='testBatch@harvard.edu';
        ID batchprocessid = Database.executeBatch(myObj);
        String myPage = '/apex/ConfirmationOfHUDUpdateForBatch?myObject=location&myCount=' + batchprocessid;
        PageReference pageRef = new PageReference(myPage);
        return pageRef;
    }
    
     public PageReference phoneUpdate() {
        HUDPhonesUpdateByContactsBatch myObj = new HUDPhonesUpdateByContactsBatch();
         myObj.email='testBatch@harvard.edu';
        ID batchprocessid = Database.executeBatch(myObj);
        String myPage = '/apex/ConfirmationOfHUDUpdateForBatch?myObject=phone&myCount=' + batchprocessid;
        PageReference pageRef = new PageReference(myPage);
        return pageRef;
    }    
   
   
    
    public PageReference affiliationUpdateContact() {
        HED_AffiliationsUpdateByContactsBatch myObj = new HED_AffiliationsUpdateByContactsBatch();
         myObj.email='testBatch@harvard.edu';
        ID batchprocessid = Database.executeBatch(myObj);
        String myPage = '/apex/ConfirmationOfHUDUpdateForBatch?myObject=affiliation&myCount=' + batchprocessid;
        PageReference pageRef = new PageReference(myPage);
        return pageRef;
    }
    
    
   

    public myTestForBatchController()
    {
         
    }
  
  
}