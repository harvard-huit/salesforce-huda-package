/*
Enter the following to the Developer Console

HUDEmailsUpdateByContactsBatch batchJob = new HUDEmailsUpdateByContactsBatch();

batchJob.query = 'select id, MULE_UNIQUE_PERSON_KEY__c, Email_Contact__c from hud_Email__c where Email_Contact__c=null';

batchJob.email='testBatch@harvard.edu';


ID batchprocessid = Database.executeBatch(batchJob);
*/

global class HUDEmailsUpdateByContactsBatch implements Database.Batchable<sObject>{
public String email;


global Database.querylocator start(Database.BatchableContext BC){
       return Database.getQueryLocator([select id, MULE_UNIQUE_PERSON_KEY__c, Email_Contact__c from hud_Email__c where Email_Contact__c=null]);}

global void execute(Database.BatchableContext BC, List<sObject> scope){
    for(sObject s : scope){hud_Email__c myRecord = (hud_Email__c)s;
        Contact[] contacts = [select id from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c limit 1];
            if(contacts!=null && !contacts.isEmpty() && myRecord.MULE_UNIQUE_PERSON_KEY__c!=null) {
                for(Contact myContact: contacts) {
                        myRecord.Email_Contact__c=myContact.id;
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