// this class moves emails from the HUDA__hud_Email__c to the Contact.Email_Address__c field
@Deprecated
global class Contact_EmailField_Update_Batch implements Database.Batchable<sObject>{
    public String email;


    global Database.querylocator start(Database.BatchableContext BC){
           return Database.getQueryLocator([SELECT Id, Email FROM Contact]);
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope){
        List<Contact> toUpdate = new List<Contact>();
        Map<Id, Contact> scopeAsMap = new Map<Id, Contact>(scope);
        hud_Email__c[] allEmailObjs = [
            select id, Email_address__c, Email_Contact__c 
            from hud_Email__c 
            where Email_Contact__c in :scopeAsMap.keySet()
            and OFFICIAL_EMAIL_INDICATOR__c='1' 
            and EFF_STATUS__c='A' 
        ];
        for(Contact myRecord : scope){
            boolean matchedBefore = false;
            // filter allEmailObjs to ones for just this contact
            List<hud_Email__c> emailObjs = new List<hud_Email__c>();
            for (hud_Email__c e : allEmailObjs) {
                if (e.Email_Contact__c == myRecord.Id) {
                    emailObjs.add(e);
                }
            }
            if(emailObjs!=null && !emailObjs.isEmpty()) {
                for(hud_Email__c myObj: emailObjs) {
                    if (myRecord.Email !=null && myRecord.Email == myObj.Email_address__c){
                        matchedBefore = true;
                    } else {
                        myRecord.Email = myObj.Email_address__c;
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

    global void finish(Database.BatchableContext BC){
        
    }

}