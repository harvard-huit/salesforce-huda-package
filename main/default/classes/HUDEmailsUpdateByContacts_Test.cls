@isTest(seeAllData=false)
private class HUDEmailsUpdateByContacts_Test {

  public static List<Contact> contactsList;
  public static List<hud_Email__c> emailsList;
  public static String MULE_KEY;
  public static HUDEmailsUpdateByContacts myMethod;
   
  static void init(){
     myMethod = new HUDEmailsUpdateByContacts();
     contactsList = new List<Contact>();
     emailsList = new List<hud_Email__c>();
     MULE_KEY = 'abcdefg';
     emailsList.add(new hud_Email__c(
           MULE_UNIQUE_PERSON_KEY__c = MULE_KEY
     ));
  }

  /** Test with creating an email object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     
     
     insert emailsList;
     
     contactsList.add(new Contact(
         hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
         LastName = 'Smith'
     ));
     insert contactsList;
     
     myMethod.runUpdate();
     
     // Getting the hud_Address to verify that the ‘Email_Contact__c’ field is not null
     emailsList = [
         SELECT Id, Email_Contact__c
         FROM hud_Email__c
         WHERE Id =:emailsList[0].Id
     ];
     
     // Verification
     System.assertEquals(emailsList[0].Email_Contact__c, contactsList[0].Id);
     
     Test.stopTest();
  }
   
    
  
  
}