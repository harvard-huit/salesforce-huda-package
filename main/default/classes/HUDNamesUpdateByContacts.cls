/* mapping name and their parents
update the last name in the contact object and 
update the account name in the account

*/
public class HUDNamesUpdateByContacts {

   public HUDNamesUpdateByContacts()
   {
   }

   //main function
   public integer runUpdate() {
        integer count=0;
        
        List<Contact> contactsToUpdate = new List<Contact>();
        List<Account> accountsToUpdate = new List<Account>();
        
        
        //run on demand, size is 10 since the query limit is 100 in synchronous call
        
        hud_Name__c[] recordsName = [select id, MULE_UNIQUE_PERSON_KEY__c, Name_Contact__c, NAME_TYPE__c, NAME_LAST__c, NAME_FIRST__c, eff_status__c from hud_Name__c where Name_Contact__c=null limit 10];
        
     
        //Due to recent change, we will use MULE_UNIQUE_PERSON_KEY__c instead of univ_id__c to map.
        if(recordsName!=null && !recordsName.isEmpty()) {
            for(hud_Name__c myRecord: recordsName) {
                Contact[] contacts = [select id, LastName, AccountId from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c];
                if(contacts!=null && !contacts.isEmpty() && myRecord.MULE_UNIQUE_PERSON_KEY__c!=null) {
                    for(Contact myContact: contacts) {
                        myRecord.Name_Contact__c=myContact.id;
                        //update myRecord;
                        count ++;
                        
                        //decide if using this name to update contact and account name
                        //if this contact has no listing name, then use this official name to update contact and account name
                        //otherwise, use the listing name only to update contact and account name
                        
                        boolean updateContact=false;
                        List<hud_Name__c> listingNames =  [select id, MULE_UNIQUE_PERSON_KEY__c, Name_Contact__c, NAME_TYPE__c, NAME_LAST__c, NAME_FIRST__c, eff_status__c from hud_Name__c where eff_status__c ='A' and NAME_TYPE__c='LISTING' and MULE_UNIQUE_PERSON_KEY__c = :myRecord.MULE_UNIQUE_PERSON_KEY__c];
        

                        //updating contact lastname
                        if (myRecord.eff_status__c =='A' && myRecord.NAME_TYPE__c!=null  && 'LISTING' != myRecord.NAME_TYPE__c && listingNames.size() == 0 ) {
                            updateContact=true;
                        }
                        if (myRecord.eff_status__c =='A' && myRecord.NAME_TYPE__c!=null  && 'LISTING' == myRecord.NAME_TYPE__c) {
                            updateContact=true;
                        }
                        
                       
                        if (updateContact) {
                            myContact.LastName = myRecord.NAME_LAST__c;
                            myContact.FirstName = myRecord.NAME_FIRST__c;
                            //update myContact;
                            contactsToUpdate.add(myContact);
                            
                            //In administrative account

                            /* Do not update account names.
                            //skip account update 05/22/2018
                            //revert again, doing account name updating 06/27/2018
                            */
                            
                            Account[] accounts = [select id,Name from Account where id = :myContact.AccountId and RecordType.Name = 'Administrative'];
                            if(accounts!=null && !accounts.isEmpty()) {
                            for(Account myAccount: accounts) {
                                myAccount.Name=myRecord.NAME_LAST__c + ' Account';
                                //update myAccount;
                                accountsToUpdate.add(myAccount);
                            }  
                            }
                         } //end of updating contact lastname and account name
                         
                    }
                }
            }
            
            update recordsName;
            update contactsToUpdate;
            update accountsToUpdate;
        }
        
        /*
        //mapping contact
        for (List<hud_Name__c> records:
        [SELECT id, MULE_UNIQUE_PERSON_KEY__c, Name_Contact__c from hud_Name__c where Name_Contact__c=null limit 40]) {
            update records;    //calling trigger
            count = records.size();
        }*/
        
     
          
         return count;
   } 
}