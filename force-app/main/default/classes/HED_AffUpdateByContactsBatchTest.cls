@isTest(seeAllData=false)
private class HED_AffUpdateByContactsBatchTest {

  public static List<Contact> contactsList;
  public static List<hed__Affiliation__c> objList;
  public static String MULE_KEY;
  public static HED_AffiliationsUpdateByContactsBatch myTestClass;
   
  static void init(){
     myTestClass = new HED_AffiliationsUpdateByContactsBatch();
     myTestClass.email='testBatch@harvard.edu';
     
     contactsList = new List<Contact>();
     objList = new List<hed__Affiliation__c>();
     MULE_KEY = 'abcdefg';
     objList.add(new hed__Affiliation__c(
           hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY
     ));
  }

  /** Test with creating an Address object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     insert objList;
     
     contactsList.add(new Contact(
         hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
         LastName = 'Smith'
     ));
     insert contactsList;
   
     ID batchprocessid = Database.executeBatch(myTestClass);
     
     Test.stopTest();
     
     
     objList = [
         SELECT Id, hed__Contact__c
         FROM hed__Affiliation__c
         WHERE Id =:objList[0].Id
     ];
     
     
     
     // Verification
     System.assertEquals(contactsList[0].Id, objList[0].hed__Contact__c);
   }
}