/*
Enter the following to the Developer Console

HUDAddressesUpdateByContactsBatch batchJob = new HUDAddressesUpdateByContactsBatch();

batchJob.query = 'select id, MULE_UNIQUE_PERSON_KEY__c, Address_Contact__c from hud_Address__c where Address_Contact__c=null';

batchJob.email='testBatch@harvard.edu';


ID batchprocessid = Database.executeBatch(batchJob);
*/

@Deprecated
global class HUDAddressesUpdateByContactsBatch implements Database.Batchable<sObject>{
public String email;


global Database.querylocator start(Database.BatchableContext BC){
       return Database.getQueryLocator([select id, MULE_UNIQUE_PERSON_KEY__c, Address_Contact__c from hud_Address__c where Address_Contact__c=null]);}

global void execute(Database.BatchableContext BC, List<sObject> scope){
    for(sObject s : scope){hud_Address__c myRecord = (hud_Address__c)s;
        Contact[] contacts = [select id from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c limit 1];
            if(contacts!=null && !contacts.isEmpty() && myRecord.MULE_UNIQUE_PERSON_KEY__c!=null) {
                for(Contact myContact: contacts) {
                        myRecord.Address_Contact__c=myContact.id;
                }
           }
    }
    update scope;
}

global void finish(Database.BatchableContext BC){
    /* 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
    mail.setToAddresses(new String[] {email});
    mail.setReplyTo('HUIT_Salesforce@harvard.edu');
    mail.setSenderDisplayName('Batch Processing');
    mail.setSubject('Batch Process Completed');
    mail.setPlainTextBody('Batch Process has completed.');
    
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    */
}
}