@Deprecated
public class HED_AffiliationsUpdateByContacts {
    
public HED_AffiliationsUpdateByContacts()
   {
   }

   public integer runUpdate() {
    integer count=0; 
    
     hed__Affiliation__c[] recordsName = [SELECT id, hud_MULE_UNIQUE_PERSON_KEY__c, hed__Contact__c, hud_DEPT_ID__c from hed__Affiliation__c where hed__Contact__c=null and hud_MULE_UNIQUE_PERSON_KEY__c !=null limit 48];
     if(recordsName!=null && !recordsName.isEmpty()) {
        for(hed__Affiliation__c a: recordsName) {
            //mapping contact
            for (List<Contact> records:
            [select id from Contact where hud_MULE_UNIQUE_PERSON_KEY__c = :a.hud_MULE_UNIQUE_PERSON_KEY__c order by id asc limit 1]){
                for(Contact myContact: records) {
                    a.hed__Contact__c=myContact.id;
                }
            }
        
            //mapping account
            if (a.hud_DEPT_ID__c !=null){
                for (List<Account> records2:
                [select id from Account where hud_DEPT_ID__c = :a.hud_DEPT_ID__c limit 1]) {
                    for(Account myAccount: records2) {
                        a.hed__Account__c=myAccount.id;
                    }
                }
            }
        
         }
         update recordsName;
         count = recordsName.size();
      }
      
     return count;
   } 
}

/*sarah notes*/
/*
     Contact and Account are two objects in the update Affliliation Trigger.
     The number of calls are counted seperately.
     So in the calling class file, I have to set the limit to 48 to prevent passing the limit of 100.
*/