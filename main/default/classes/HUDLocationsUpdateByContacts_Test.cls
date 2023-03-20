@isTest(seeAllData=false)
private class HUDLocationsUpdateByContacts_Test {

  public static List<Contact> contactsList;
  public static List<hud_Location__c> LocationsList;
  public static String MULE_KEY;
  public static HUDLocationsUpdateByContacts myMethod;
   
  static void init(){
     myMethod = new HUDLocationsUpdateByContacts();
     contactsList = new List<Contact>();
     LocationsList = new List<hud_Location__c>();
     MULE_KEY = 'abcdefg';
     LocationsList.add(new hud_Location__c(
           MULE_UNIQUE_PERSON_KEY__c = MULE_KEY
     ));
  }

  /** Test with creating an Location object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     
     
     insert LocationsList;
     
     contactsList.add(new Contact(
         hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
         Lastname = 'Smith'
     ));
     insert contactsList;
     
     myMethod.runUpdate();
     
     // Getting the hud_Address to verify that the ‘Location_Contact__c’ field is not null
     LocationsList = [
         SELECT Id, Location_Contact__c
         FROM hud_Location__c
         WHERE Id =:LocationsList[0].Id
     ];
     
     // Verification
     System.assertEquals(LocationsList[0].Location_Contact__c, contactsList[0].Id);
     
     Test.stopTest();
  }
   
    
  
  
}