/*

*/
@Deprecated
public class HUDAddressesUpdateByContacts {

   public HUDAddressesUpdateByContacts()
   {
   }

   public integer runUpdate() {
   	
   		integer count=0;
        
        hud_Address__c[] recordsAddress = [select id, MULE_UNIQUE_PERSON_KEY__c, Address_Contact__c from hud_Address__c where Address_Contact__c=null limit 99];
       
        
        if(recordsAddress!=null && !recordsAddress.isEmpty()) {
            for(hud_Address__c myRecord: recordsAddress) {
                Contact[] contacts = [select id from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c limit 1];
                if(contacts!=null && !contacts.isEmpty() && myRecord.MULE_UNIQUE_PERSON_KEY__c!=null) {
                    for(Contact myContact: contacts) {
                        myRecord.Address_Contact__c=myContact.id;
                        //update myRecord;
                        count ++;
                    }
                }
     
            }
             update recordsAddress;
        }
   	
   	
   	 /*
        //reset contact
      	for (List<hud_Address__c> records:
      	[SELECT id, MULE_UNIQUE_PERSON_KEY__c, Address_Contact__c from hud_Address__c where Address_Contact__c!=null  limit 50]) {
        	update records;    //calling trigger
        	count = records.size();
      	}
    */
   
   /*
    //mapping contact
    for (List<hud_Address__c> records:
    [SELECT id, MULE_UNIQUE_PERSON_KEY__c, Address_Contact__c from hud_Address__c where Address_Contact__c=null limit 99]) {
    	update records;    //calling trigger
        count = records.size();
    }
    */
      
     return count;
   } 
   

}