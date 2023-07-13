@Deprecated
global class HUDNameToUpdateContactsBatch implements Database.Batchable<sObject>{
	public String email;

    global Database.querylocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([
            select id,LastName, FirstName, hud_MULE_UNIQUE_PERSON_KEY__c 
            from Contact 
            where hud_MULE_UNIQUE_PERSON_KEY__c != null
        ]);
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope){

        Set<String> muleKeys = new Set<String>();
        for (Contact c : scope) {
            muleKeys.add(c.hud_MULE_UNIQUE_PERSON_KEY__c);
        }
        
        List<hud_Name__c> allObjs =          [
            select id,NAME_TYPE__c,NAME_LAST__c, NAME_FIRST__c, eff_status__c, MULE_UNIQUE_PERSON_KEY__c 
            from hud_Name__c 
            where MULE_UNIQUE_PERSON_KEY__c in :muleKeys
            and eff_status__c ='A'
        ];

        List<hud_Name__c> allListingNames =  [
            select id,MULE_UNIQUE_PERSON_KEY__c, Name_Contact__c, NAME_TYPE__c, NAME_LAST__c, NAME_FIRST__c, eff_status__c 
            from hud_Name__c 
            where eff_status__c ='A' 
            and NAME_TYPE__c='LISTING' 
            and MULE_UNIQUE_PERSON_KEY__c in :muleKeys
        ];

        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact myRecord : scope){

            List<hud_Name__c> objs = filterToMuleKey(myRecord.hud_MULE_UNIQUE_PERSON_KEY__c, allObjs);
            List<hud_Name__c> listingNames = filterToMuleKey(myRecord.hud_MULE_UNIQUE_PERSON_KEY__c, allListingNames);

            //if this contact has no listing name, then use this official name to update contact
            //otherwise, use the listing name to update contact
                            
            if(objs!=null && !objs.isEmpty() && myRecord.hud_MULE_UNIQUE_PERSON_KEY__c!=null) {
                for(hud_Name__c myObj: objs) {
                    boolean updateContact=false;
                    if (myObj.eff_status__c =='A' && myObj.NAME_TYPE__c!=null  && 'LISTING' != myObj.NAME_TYPE__c && listingNames.size() == 0 ) {
                        updateContact=true;
                    }
                    if (myObj.eff_status__c =='A' && myObj.NAME_TYPE__c!=null  && 'LISTING' == myObj.NAME_TYPE__c) {
                        updateContact=true;
                    }

                    if (updateContact) {
                        //check if the current name is the same as the HUD_Name
                        if (myRecord.LastName != myObj.NAME_LAST__c || myRecord.FirstName != myObj.NAME_FIRST__c){
                            //updating contact lastname
                            myRecord.LastName = myObj.NAME_LAST__c;
                            myRecord.FirstName = myObj.NAME_FIRST__c;
                            contactsToUpdate.add(myRecord);
                        }
                    }
                } 
                             
            }
                 
        }
        update contactsToUpdate;
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