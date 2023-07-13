@Deprecated
global class HUDNamesUpdateByContactsBatch implements Database.Batchable<sObject>{
public String email;


global Database.querylocator start(Database.BatchableContext BC){
       return Database.getQueryLocator([select id, MULE_UNIQUE_PERSON_KEY__c, Name_Contact__c, NAME_TYPE__c, NAME_LAST__c, NAME_FIRST__c from hud_Name__c where Name_Contact__c=null]);}

global void execute(Database.BatchableContext BC, List<sObject> scope){
    
    try{    
    for(sObject s : scope){hud_Name__c myRecord = (hud_Name__c)s;
        Contact[] contacts = [select id from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c limit 1];
            if(contacts!=null && !contacts.isEmpty() && myRecord.MULE_UNIQUE_PERSON_KEY__c!=null) {
                for(Contact myContact: contacts) {
                        myRecord.Name_Contact__c=myContact.id;
                    }
           }
    }
    update scope;
    }
            catch (Exception e) {  
                HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
                Error_Log__c log = new Error_Log__c();
                
                log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
                
                log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
                + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
                + 'Class Name: ' + 'HUDAddressesUpdateByContacts in scheduled job';
                insert log;   
            }
    
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