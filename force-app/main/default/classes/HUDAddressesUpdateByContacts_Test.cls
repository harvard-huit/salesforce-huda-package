@isTest(seeAllData=false)
private class HUDAddressesUpdateByContacts_Test {

  public static List<Contact> contactsList;
  public static List<hud_Address__c> addressesList;
  public static String MULE_KEY;
  public static HUDAddressesUpdateByContacts myMethod;
   
  static void init(){
     myMethod = new HUDAddressesUpdateByContacts();
     contactsList = new List<Contact>();
     addressesList = new List<hud_Address__c>();
    MULE_KEY = 'abcdefg';
    addressesList.add(new hud_Address__c(
           MULE_UNIQUE_PERSON_KEY__c = MULE_KEY
     ));
  }

  /** Test with creating an address object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     
     
     insert addressesList;
     
     contactsList.add(new Contact(
         hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
         LastName = 'Smith'
     ));
     insert contactsList;
     
     myMethod.runUpdate();
     
     // Getting the hud_Address to verify that the ‘Address_Contact__c’ field is not null
     addressesList = [
         SELECT Id, Address_Contact__c
         FROM hud_Address__c
         WHERE Id =:addressesList[0].Id
     ];
     
     // Verification
     System.assertEquals(addressesList[0].Address_Contact__c, contactsList[0].Id);
     //System.assertEquals(addressesList[0].Address_Contact__c, null);
     
     Test.stopTest();
  }
   
    
  
  
}