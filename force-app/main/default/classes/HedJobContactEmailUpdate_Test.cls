/**
 
 */
@isTest
private class HedJobContactEmailUpdate_Test {
  public static List<Contact> contactsList;
 
  public static List<hud_Email__c> emailsList;
 
  public static Contact_EmailField_Update_Batch myTestClass;
  
  
  static void init(){
     
    contactsList = new List<Contact>();
    
    emailsList = new List<hud_Email__c>();
    
  }

  /** Test with creating an Location object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     contactsList.add(new Contact(
        FirstName = 'Mary',
        LastName = 'Jane',
    Email = 'dev@harvard.edu'
    ));
    insert contactsList;
    
    
    emailsList.add(new hud_Email__c(
        Email_Contact__c = contactsList[0].Id,
        Email_address__c = 'test@harvard.edu',
        OFFICIAL_EMAIL_INDICATOR__c = '1',
        EFF_Status__c = '1'
    ));
   insert emailsList;
   
    GlobalVariable__c myVari = new GlobalVariable__c();
       myVari.name = 'Email Address for Email Alerts';
       myVari.value__c = 'test_receiver@harvard.edu';
       insert myVari;
   
   
  
   
   
    //testing scheduling part
      // Schedule a sccheduled job
       String jobId = System.schedule('TestHedJobContactEmailUpdate',
            HedJobContactEmailUpdate.CRON_EXP, 
            new HedJobContactEmailUpdate());

      // Get the information from the CronTrigger API object
      CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime
         FROM CronTrigger WHERE id = :jobId];

      // Verify the expressions are the same
      System.assertEquals(HedJobContactEmailUpdate.CRON_EXP, 
         ct.CronExpression);

      // Verify the job has not run
      System.assertEquals(0, ct.TimesTriggered);
     
     Test.stopTest();
     
     
     
     contactsList = [
         SELECT Id, Email
         FROM Contact
         WHERE Id =:contactsList[0].Id
     ];
     
     
     
     // Verification     
     System.assertEquals(contactsList[0].Email,'dev@harvard.edu');
   }
}