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
private class HUDJobSelfSchedule_Test {

    static testmethod void test() {
        Test.startTest();

       hud_Email__c Obj = new hud_Email__c();
       Obj.MULE_UNIQUE_PERSON_KEY__c = '91156500';
       insert Obj;

      // Verify the next time the job will run
      // The following line might need to comment out when deploying it to prod.
      //System.assertEquals('2016-12-01 13:40:00', 
         //String.valueOf(ct.NextFireTime));
       
     
      
       Contact a = new Contact();
       a.hud_MULE_UNIQUE_PERSON_KEY__c = '91156500';
       a.LastName = 'Smith';
       insert a;
       
       
        Test.stopTest();

        System.assertEquals(a.Id,
        [SELECT Id, Email_Contact__c FROM hud_Email__c WHERE Id = :Obj.Id].Email_Contact__c);
   }
}