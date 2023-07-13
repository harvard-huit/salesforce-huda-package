@Deprecated
global class HED_AffiliationsUpdateByContactsBatch implements Database.Batchable<sObject>{
public String email;


global Database.querylocator start(Database.BatchableContext BC){
       return Database.getQueryLocator([SELECT id, hud_MULE_UNIQUE_PERSON_KEY__c, hed__Contact__c, hud_DEPT_ID__c from hed__Affiliation__c where hed__Contact__c=null and hud_MULE_UNIQUE_PERSON_KEY__c !=null]);}

global void execute(Database.BatchableContext BC, List<hed__Affiliation__c> scope){
    try{
       List<hed__Affiliation__c> toUpdate = new List<hed__Affiliation__c>();
        
        Set<String> myKeys = new Set<String>();
        for (hed__Affiliation__c a : scope) {
            myKeys.add(a.hud_MULE_UNIQUE_PERSON_KEY__c);
        }
        
        Contact[] allContactObjs = [select id, hud_MULE_UNIQUE_PERSON_KEY__c from Contact where hud_MULE_UNIQUE_PERSON_KEY__c in :myKeys];
       
       
		for(hed__Affiliation__c myRecord : scope){
			
			 boolean matchedBefore = false;
			 
			 // filter allContactObjs to ones for just this hed__Affiliation__c
            List<Contact> ContactObjs = new List<Contact>();
            for (Contact e : allContactObjs) {
                if (e.hud_MULE_UNIQUE_PERSON_KEY__c == myRecord.hud_MULE_UNIQUE_PERSON_KEY__c) {
                    ContactObjs.add(e);
                }
            }
            
            
             if(ContactObjs!=null && !ContactObjs.isEmpty()) {
                for(Contact myObj: ContactObjs) {
                    if (myRecord.hud_MULE_UNIQUE_PERSON_KEY__c !=null && myRecord.hed__Contact__c !=null && myRecord.hed__Contact__c == myObj.id){
                        matchedBefore = true;
                    } else {
                        myRecord.hed__Contact__c = myObj.id;
                        toUpdate.add(myRecord);
                    }
                }         
            }
	    }
	    update toUpdate;
    }
    catch (Exception e) {  
            
                HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
                Error_Log__c log = new Error_Log__c();
                
                log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
            
                log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
            
                + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
            
                + 'Class Name: ' + 'HED_AffiliationsUpdateByContactsBatch';
            
                insert log;   
            
            }
    
}

global void finish(Database.BatchableContext BC){
    //Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
    //mail.setToAddresses(new String[] {email});
    //mail.setReplyTo('batch_notification_SF@harvard.edu');
    //mail.setSenderDisplayName('Batch Processing');
    //mail.setSubject('Batch Process Completed');
    //mail.setPlainTextBody('Batch Process has completed');
    
    //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}
}