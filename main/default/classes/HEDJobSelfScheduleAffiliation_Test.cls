/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class HEDJobSelfScheduleAffiliation_Test {

    static testmethod void test() {
        Test.startTest();

       hed__Affiliation__c myObj = new hed__Affiliation__c();
       myObj.hud_DEPT_ID__c = '1234abc';
       myObj.hud_MULE_UNIQUE_PERSON_KEY__c = '1234';
       insert myObj;
       
       GlobalVariable__c myVari = new GlobalVariable__c();
       myVari.name = 'Email Address for Email Alerts';
       myVari.value__c = 'test_receiver@harvard.edu';
       insert myVari;
       

      // Schedule the test job
            
      //  String jobId = System.schedule('testScheduledApex',
      //       HEDJobSelfScheduleAffiliation.CRON_EXP, 
      //       new HEDJobSelfScheduleAffiliation());
               

      // Get the information from the CronTrigger API object
      // CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
      //    NextFireTime
      //    FROM CronTrigger WHERE id = :jobId];

      // Verify the expressions are the same
      // System.assertEquals(HEDJobSelfScheduleAffiliation.CRON_EXP, 
      //    ct.CronExpression);

      // Verify the job has not run
      // System.assertEquals(0, ct.TimesTriggered);
      
       Account a = new Account();
       a.hud_DEPT_ID__c = '1234abc';
       a.Name = 'test';
       
       insert a;
       
       Contact b = new Contact();
       b.hud_MULE_UNIQUE_PERSON_KEY__c = '1234';
       b.LastName = 'Smith';
       
       insert b;
       
       Test.stopTest();
       
        

        System.assertEquals(a.Id, [SELECT Id, hed__Account__c FROM hed__Affiliation__c WHERE Id = :myObj.Id].hed__Account__c);
        
        System.assertEquals(b.Id, [SELECT Id, hed__Contact__c FROM hed__Affiliation__c WHERE Id = :myObj.Id].hed__Contact__c);
        
        //System.assertEquals(null, [SELECT Id, hed__Account__c FROM hed__Affiliation__c WHERE Id = :myObj.Id].hed__Account__c);
        
        //System.assertEquals(null, [SELECT Id, hed__Contact__c FROM hed__Affiliation__c WHERE Id = :myObj.Id].hed__Contact__c);
       
      
       

   }
}