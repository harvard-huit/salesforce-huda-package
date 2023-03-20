/*

*/
public class HUDLocationsUpdateByContacts {

   public HUDLocationsUpdateByContacts()
   {
   }

   public integer runUpdate() {
        integer count=0; 
        
        hud_Location__c[] recordsLocation = [select id, MULE_UNIQUE_PERSON_KEY__c, Location_Contact__c from hud_Location__c where Location_Contact__c=null limit 99];
     	
     	
        if(recordsLocation!=null && !recordsLocation.isEmpty()) {
            for(hud_Location__c myRecord: recordsLocation) {
                Contact[] contacts = [select id from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c limit 1];
                if(contacts!=null && !contacts.isEmpty() && myRecord.MULE_UNIQUE_PERSON_KEY__c!=null) {
                    for(Contact myContact: contacts) {
                        myRecord.Location_Contact__c=myContact.id;
                        //update myRecord;
                        count ++;
                    }
                }
     
            }
            update recordsLocation;
        }
       
        
        /*
	    //mapping contact
	    for (List<hud_Location__c> records:
	    [SELECT id, MULE_UNIQUE_PERSON_KEY__c, Location_Contact__c from hud_Location__c where Location_Contact__c=null limit 99]) {
	    	update records;    //calling trigger
	        count = records.size();
	    }
	    */
	      
	     return count;
   } 
   

}