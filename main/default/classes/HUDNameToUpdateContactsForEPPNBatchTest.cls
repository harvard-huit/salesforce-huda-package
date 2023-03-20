@isTest
private class HUDNameToUpdateContactsForEPPNBatchTest {

  public static List<Contact> contactsList;
  public static List<hud_Name__c> objList;
  public static String MULE_KEY;
  public static HUDNameToUpdateContactsForEPPNBatch myTestClass;
   
  static void init(){
     myTestClass = new HUDNameToUpdateContactsForEPPNBatch();
     myTestClass.email='testBatch@harvard.edu';
     
     contactsList = new List<Contact>();
     objList = new List<hud_Name__c>();
     MULE_KEY = 'abcdefg';
     objList.add(new hud_Name__c(
           NAME_LAST__c = 'namelast@harvard.edu',
           NAME_FIRST__c = 'namefirst@harvard.edu',
           MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
           NAME_TYPE__c='LISTING',
           eff_status__c ='A'
     ));
  }

  /** Test with creating a Name object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     insert objList;
     
     contactsList.add(new Contact(
         hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
         LastName = 'acd3d0471e7ed076'
     ));
     insert contactsList;
   
     ID batchprocessid = Database.executeBatch(myTestClass);
    
     Test.stopTest();
     
     contactsList = [
         SELECT Id, FirstName, LastName 
         FROM Contact
         WHERE Id =:contactsList[0].Id
     ];
     
     // Verification
     System.assertEquals(contactsList[0].FirstName, 'namefirst@harvard.edu');
     System.assertEquals(contactsList[0].LastName, 'namelast@harvard.edu');
   }
}