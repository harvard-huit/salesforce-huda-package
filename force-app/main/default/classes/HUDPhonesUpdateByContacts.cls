/*

*/
public class HUDPhonesUpdateByContacts {

   public HUDPhonesUpdateByContacts()
   {
   }

   public integer runUpdate() {
   	 integer count=0; 
   	 
       
        Hud_Phone__c[] recordsPhone = [select id, MULE_UNIQUE_PERSON_KEY__c, Phone_Contact__c from hud_Phone__c where Phone_Contact__c=null limit 99];
        
     
        if(recordsPhone!=null && !recordsPhone.isEmpty()) {
            for(hud_Phone__c myRecord: recordsPhone) {
                Contact[] contacts = [select id from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c];
                if(contacts!=null && !contacts.isEmpty() && myRecord.MULE_UNIQUE_PERSON_KEY__c!=null) {
                    for(Contact myContact: contacts) {
                        myRecord.Phone_Contact__c=myContact.id;
                        //update myRecord;
                        count ++;
                    }
                }
     
            }
            update recordsPhone;
        }
       
        
       
        /*
	    //mapping contact
	    for (List<hud_Phone__c> records:
	    [SELECT id, MULE_UNIQUE_PERSON_KEY__c, Phone_Contact__c from hud_Phone__c where Phone_Contact__c=null limit 99]) {
	    	update records;    //calling trigger
	        count = records.size();
	    }
	    */
	      
	     return count;
        
   } 
   

}