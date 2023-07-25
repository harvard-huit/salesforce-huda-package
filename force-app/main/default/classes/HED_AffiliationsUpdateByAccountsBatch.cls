global class HED_AffiliationsUpdateByAccountsBatch implements Database.Batchable<sObject>{
public String email;


global Database.querylocator start(Database.BatchableContext BC){
       return Database.getQueryLocator([SELECT id, hud_MULE_UNIQUE_PERSON_KEY__c, hed__Contact__c, hud_DEPT_ID__c, hed__Account__c from hed__Affiliation__c where hud_DEPT_ID__c !=null]);}

global void execute(Database.BatchableContext BC, List<hed__Affiliation__c> scope){
	 try{
		List<hed__Affiliation__c> toUpdate = new List<hed__Affiliation__c>();
        
        Set<String> myKeys = new Set<String>();
        for (hed__Affiliation__c a : scope) {
            myKeys.add(a.hud_DEPT_ID__c);
        }
        
        Account[] allAccountObjs = [select id, hud_DEPT_ID__c from Account where hud_DEPT_ID__c in :myKeys];
       
       
		for(hed__Affiliation__c myRecord : scope){
			
			 boolean matchedBefore = false;
			 
            // filter allAccountObjs to ones for just this hed__Affiliation__c
            List<Account> accountObjs = new List<Account>();
            for (Account e : allAccountObjs) {
                if (e.hud_DEPT_ID__c == myRecord.hud_DEPT_ID__c) {
                    accountObjs.add(e);
                }
            }
            
             if(accountObjs!=null && !accountObjs.isEmpty()) {
                for(Account myObj: accountObjs) {
                	//no change
                    if (myRecord.hud_DEPT_ID__c !=null && myRecord.hed__Account__c !=null && myRecord.hed__Account__c == myObj.id){
                        matchedBefore = true;                        
                    } else {
                        myRecord.hed__Account__c = myObj.id;
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