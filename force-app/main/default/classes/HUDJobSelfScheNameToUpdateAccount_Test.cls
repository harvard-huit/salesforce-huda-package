@isTest
private class HUDJobSelfScheNameToUpdateAccount_Test {
public static List<Contact> contactsList;
  public static List<Account> objList;
   
  static void init(){
   
     
     contactsList = new List<Contact>();
     objList = new List<Account>();
    
     objList.add(new Account(
           Name = 'test'
     ));
  }

  /** Test with creating a Name object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     insert objList;
     
     contactsList.add(new Contact(
         AccountId = objList[0].Id,
         LastName = 'mylastname'
     ));
     insert contactsList;
   
      GlobalVariable__c myVari = new GlobalVariable__c();
       myVari.name = 'Email Address for Email Alerts';
       myVari.value__c = 'test_receiver@harvard.edu';
       insert myVari;

      // Schedule the test job
      //  String jobId = System.schedule('testScheduledApex',
      //       HUDJobSelfScheduleNameToUpdateAccount.CRON_EXP, 
      //       new HUDJobSelfScheduleNameToUpdateAccount());
     
    
     Test.stopTest();
     
     objList = [
         SELECT Id, Name  
         FROM Account
         WHERE Id =:objList[0].Id
     ];
     
     // Verification
     //System.assertEquals('mylastname Account', objList[0].Name);
    
   }
}