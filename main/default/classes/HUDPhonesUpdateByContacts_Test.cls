@isTest(seeAllData=false)
private class HUDPhonesUpdateByContacts_Test {

  public static List<Contact> contactsList;
  public static List<hud_Phone__c> PhonesList;
  public static String MULE_KEY;
  public static HUDPhonesUpdateByContacts myMethod;
   
  static void init(){
     myMethod = new HUDPhonesUpdateByContacts();
     contactsList = new List<Contact>();
     PhonesList = new List<hud_Phone__c>();
     MULE_KEY = 'abcdefg';
     PhonesList.add(new hud_Phone__c(
           MULE_UNIQUE_PERSON_KEY__c = MULE_KEY
     ));
  }

  /** Test with creating an Phone object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     
     
     insert PhonesList;
     
     contactsList.add(new Contact(
         hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
         LastName = 'Smith'
     ));
     insert contactsList;
     
     myMethod.runUpdate();
     
     // Getting the hud_Address to verify that the ‘Phone_Contact__c’ field is not null
     PhonesList = [
         SELECT Id, Phone_Contact__c
         FROM hud_Phone__c
         WHERE Id =:PhonesList[0].Id
     ];
     
     // Verification
     System.assertEquals(PhonesList[0].Phone_Contact__c, contactsList[0].Id);
     
     Test.stopTest();
  }
   
    
  
  
}