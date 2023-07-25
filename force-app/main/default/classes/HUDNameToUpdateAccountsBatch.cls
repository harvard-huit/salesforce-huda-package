global class HUDNameToUpdateAccountsBatch implements Database.Batchable<sObject>{
    public String email;


global Database.querylocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([
            select Id, Name 
            from Account 
            where RecordType.Name = 'Administrative'
        ]);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
    
    /*
        Set<String> accountIds= new Set<String>();
        for (Account c : scope) {
            accountIds.add(c.id);
        }
        
        List<contact> allObjs =          [
            select id,LastName, AccountId  
            from contact
            where AccountId in :accountIds
        ];

       

        List<Account> AccountsToUpdate = new List<Account>();
        
        for(Account myRecord : scope){
        */
        
        Set<String> accountIds= new Set<String>();
        for (sObject c : scope) {
            accountIds.add(c.id);
        }
        
        List<contact> allObjs =          [
            select id,LastName, AccountId  
            from contact
            where AccountId in :accountIds
        ];

       

        List<Account> AccountsToUpdate = new List<Account>();
        
        for(sObject  s: scope){
            Account myRecord = (Account)s;

            List<contact> objs = filterToId(myRecord.id, allObjs);
            
                            
            if(objs!=null && !objs.isEmpty()) {
                for(contact myObj: objs) {
                    boolean updateAccount=false;
                    

                    if (myRecord.Name != myObj.LastName + ' Account'){
                        myRecord.Name = myObj.LastName + ' Account';
                        AccountsToUpdate.add(myRecord);
                        updateAccount=true;
                    }
                    
                }
                             
            }
                 
        }
        update AccountsToUpdate; 
    }

    private static List<contact> filterToId (String idStr, List<contact> listToFilter) {
        List<contact> res = new List<contact>();
        for (contact n : listToFilter) {
            if (n.AccountId == idStr) {
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