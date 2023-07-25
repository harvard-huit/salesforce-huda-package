global class HUDNameToUpdateContactsForEPPNBatch implements Database.Batchable<sObject>{
    public String email;


    global Database.querylocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([
            select id,LastName, FirstName,hud_MULE_UNIQUE_PERSON_KEY__c 
            from Contact 
            // TODO move this to a formula to check if it's numeric type 
            where LastName like '%0%' 
            or LastName like '%1%' 
            or LastName like '%2%' 
            or LastName like '%3%' 
            or LastName like '%4%' 
            or LastName like '%5%' 
            or LastName like '%6%' 
            or LastName like '%7%' 
            or LastName like '%8%' 
            or LastName like '%9%'
        ]);
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope){
        List<Contact> toUpdate = new List<Contact>();
        Set<String> muleKeys = new Set<String>();
        for (Contact c : scope) {
            muleKeys.add(c.hud_MULE_UNIQUE_PERSON_KEY__c);
        }
        hud_Name__c[] allObjs = [
            select id,NAME_TYPE__c,NAME_LAST__c, NAME_FIRST__c, MULE_UNIQUE_PERSON_KEY__c 
            from hud_Name__c 
            where MULE_UNIQUE_PERSON_KEY__c in :muleKeys
            and eff_status__c ='A'
        ];
        List<hud_Name__c> allListingNames =  [
            select id, MULE_UNIQUE_PERSON_KEY__c, Name_Contact__c, NAME_TYPE__c, NAME_LAST__c, NAME_FIRST__c, eff_status__c 
            from hud_Name__c 
            where eff_status__c ='A' 
            and NAME_TYPE__c='LISTING' 
            and MULE_UNIQUE_PERSON_KEY__c in :muleKeys
        ];
        for(Contact myRecord : scope){
            List<hud_Name__c> objs = filterToMuleKey(myRecord.HUD_MULE_UNIQUE_PERSON_KEY__c, allObjs);
            List<hud_Name__c> listingNames = filterToMuleKey(myRecord.HUD_MULE_UNIQUE_PERSON_KEY__c, allListingNames);
            if(objs!=null && !objs.isEmpty() && myRecord.hud_MULE_UNIQUE_PERSON_KEY__c!=null) {
                for(hud_Name__c myObj: objs) {
                    //updating contact lastname
                    boolean updateContact=false;
                    if (myObj.NAME_TYPE__c!=null  && 'LISTING' != myObj.NAME_TYPE__c && listingNames.size() == 0 ) {
                        updateContact=true;
                    }
                    if (myObj.NAME_TYPE__c!=null  && 'LISTING' == myObj.NAME_TYPE__c) {
                        updateContact=true;
                    }
                    if (updateContact) {
                        myRecord.LastName = myObj.NAME_LAST__c;
                        myRecord.FirstName = myObj.NAME_FIRST__c;
                        toUpdate.add(myRecord);
                    }
                } 
                             
            }
              
        }
        //original code
        //update toUpdate;
        
         //create a map that will hold the values of the list 
        map<id,Contact> toUpdateMap = new map<id,Contact>();

        //put all the values from the list to map. 
        toUpdateMap.putall(toUpdate);
        if(toUpdateMap.size()>0){
            update toUpdateMap.values();
        }
    }

    private static List<hud_Name__c> filterToMuleKey (String muleKey, List<hud_Name__c> listToFilter) {
        List<hud_Name__c> res = new List<hud_Name__c>();
        for (hud_Name__c n : listToFilter) {
            if (n.MULE_UNIQUE_PERSON_KEY__c == muleKey) {
                res.add(n);
            }
        }
        return res;
    }

    global void finish(Database.BatchableContext BC){
        /*
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {email});
        mail.setReplyTo('HUIT_Salesforce@harvard.edu');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('Batch Process has completed successfully.');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        */
    }
}