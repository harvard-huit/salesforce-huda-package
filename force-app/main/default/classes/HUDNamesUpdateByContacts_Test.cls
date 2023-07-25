@isTest(seeAllData=false)
private class HUDNamesUpdateByContacts_Test {

  public static List<Contact> contactsList;
  public static List<hud_Name__c> NamesList;
  public static List<Account> objList;
  
  public static String MULE_KEY;
  public static HUDNamesUpdateByContacts myMethod;
   
  static void init(){
     myMethod = new HUDNamesUpdateByContacts();
     contactsList = new List<Contact>();
     NamesList = new List<hud_Name__c>();
     MULE_KEY = 'abcdefg';
     NamesList.add(new hud_Name__c(
           NAME_LAST__c = 'namelast',
           NAME_FIRST__c = 'namefirst',
           MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
           NAME_TYPE__c='LISTING',
           eff_status__c  = 'A'
     ));
     
     
     objList = new List<Account>();
     objList.add(new Account(
           Name = 'test'
     ));
     
  }

  /** Test with creating an Name object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     
     insert NamesList;
     
     insert objList;
     
     contactsList.add(new Contact(
         AccountId = objList[0].Id,
         hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
         LastName = 'Smith'
     ));
     insert contactsList;
     
     myMethod.runUpdate();
     
     Test.stopTest();
     
     // Getting the hud_Name to verify that the ‘Name_Contact__c’ field is not null
     NamesList = [
         SELECT Id, Name_Contact__c
         FROM hud_Name__c
         WHERE Id =:NamesList[0].Id
     ];
     
     contactsList = [
         SELECT Id, LastName 
         FROM Contact
         WHERE Id =:contactsList [0].Id
     ];
     
     /*
     objList = [
         SELECT Id, Name  
         FROM Account
         WHERE Id =:objList[0].Id
     ];
     */
     
     // Verification
     System.assertEquals(NamesList[0].Name_Contact__c, contactsList[0].Id);
     
     System.assertEquals(contactsList[0].LastName , 'namelast');
     
     //System.assertEquals(objList[0].Name, 'namelast Account');
     
     
  }
   
    
  
  
}