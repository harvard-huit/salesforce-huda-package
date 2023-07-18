@isTest
private class Contact_EmailField_Update_Batch_Test {
  public static List<Contact> contactsList;
  public static List<hud_Email__c> emailsList;
 
  
  public static Contact_EmailField_Update_Batch myTestClass;
   
  static void init(){
     myTestClass = new Contact_EmailField_Update_Batch();
     myTestClass.email='testBatch@harvard.edu';
     
     contactsList = new List<Contact>();
     emailsList = new List<hud_Email__c>();
  
  }

  /** Test with creating an Location object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     contactsList.add(new Contact(
         FirstName = 'Mary',
         LastName = 'Jane'
     ));
     insert contactsList;
     
     
     emailsList.add(new hud_Email__c(
         Email_Contact__c = contactsList[0].Id,
         Email_address__c = 'test@harvard.edu',
         OFFICIAL_EMAIL_INDICATOR__c = '1',
    EFF_STATUS__c='A'
     ));
   insert emailsList;
   
   
  
     
   
   
    ID batchprocessid = Database.executeBatch(myTestClass);
     
    Test.stopTest();
     
     contactsList= [
         SELECT Id, Email
         FROM Contact
         WHERE Id =:contactsList[0].Id
     ];
     
     
     
     // Verification
     System.assertEquals(contactsList[0].Email,emailsList[0].Email_address__c);
   }
}