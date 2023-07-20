global class HUDNameToUpdateAccountsBatchDataLoad implements Database.Batchable<sObject>{
public String email;


global Database.querylocator start(Database.BatchableContext BC){
       return Database.getQueryLocator([select id,Name from Account]);}

global void execute(Database.BatchableContext BC, List<sObject> scope){
    for(sObject s : scope){Account myRecord = (Account)s;
        Contact[] objs = [select id,LastName,AccountId from Contact where hud_MULE_UNIQUE_PERSON_KEY__c != null and AccountId = :myRecord.Id];
            if(objs!=null && !objs.isEmpty()) {
                for(Contact myObj: objs) {
                			if (myRecord.Name != myObj.LastName + ' Account'){
                            myRecord.Name = myObj.LastName + ' Account';
                            //update myRecord;
                			}
                            
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
    mail.setPlainTextBody('Batch Process has completed successfully.');
    
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    */
}
}