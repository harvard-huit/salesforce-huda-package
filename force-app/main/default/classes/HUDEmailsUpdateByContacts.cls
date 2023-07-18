/*

*/
@Deprecated
public class HUDEmailsUpdateByContacts {

   public HUDEmailsUpdateByContacts()
   {
   }

   public integer runUpdate() {
   	integer count=0; 
   	
      
        hud_Email__c[] recordsEmail = [select id, MULE_UNIQUE_PERSON_KEY__c, Email_Contact__c from hud_Email__c where Email_Contact__c=null limit 99];
    
     	
        if(recordsEmail!=null && !recordsEmail.isEmpty()) {
            for(hud_Email__c myRecord: recordsEmail) {
                Contact[] contacts = [select id from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c limit 1];
                if(contacts!=null && !contacts.isEmpty() && myRecord.MULE_UNIQUE_PERSON_KEY__c!=null) {
                    for(Contact myContact: contacts) {
                        myRecord.Email_Contact__c=myContact.id;
                        //update myRecord;
                        count ++;
                    }
                }
     
            }
             update recordsEmail;
        }
      
        
        
       /*
	    //mapping contact
	    for (List<hud_Email__c> records:
	    [SELECT id, MULE_UNIQUE_PERSON_KEY__c, Email_Contact__c from hud_Email__c where Email_Contact__c=null limit 99]) {
	    	update records;    //calling trigger
	        count = records.size();
	    }
	      */
	     return count;
   } 
   

}