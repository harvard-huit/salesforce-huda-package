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
@isTest(seeAllData=false)
private class HUDEmailsUpdateByContactsBatchTest {

  public static List<Contact> contactsList;
  public static List<hud_Email__c> emailsList;
  public static String MULE_KEY;
  public static HUDEmailsUpdateByContactsBatch myTestClass;
   
  static void init(){
     myTestClass = new HUDEmailsUpdateByContactsBatch();
     //myTestClass.query='select id, MULE_UNIQUE_PERSON_KEY__c, Email_Contact__c from hud_Email__c where Email_Contact__c=null';
     myTestClass.email='testBatch@harvard.edu';
     
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
   
     ID batchprocessid = Database.executeBatch(myTestClass);
     
     Test.stopTest();
     
     // Getting the hud_Address to verify that the ‘Email_Contact__c’ field is not null
     emailsList = [
         SELECT Id, Email_Contact__c
         FROM hud_Email__c
         WHERE Id =:emailsList[0].Id
     ];
     
     
     
     // Verification
     //System.assertEquals(emailsList[0].Email_Contact__c, contactsList[0].Id);
     System.assertEquals(contactsList[0].Id,
        [SELECT Id, Email_Contact__c FROM hud_Email__c WHERE Id = :emailsList[0].Id].Email_Contact__c);
   }
}