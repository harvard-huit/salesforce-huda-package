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
private class HUDNamesUpdateByContactsBatchTest {

  public static List<Contact> contactsList;
  public static List<hud_Name__c> objList;
  public static String MULE_KEY;
  public static HUDNamesUpdateByContactsBatch myTestClass;
   
  static void init(){
     myTestClass = new HUDNamesUpdateByContactsBatch();
     myTestClass.email='testBatch@harvard.edu';
     
     contactsList = new List<Contact>();
     objList = new List<hud_Name__c>();
     MULE_KEY = 'abcdefg';
     objList.add(new hud_Name__c(
           MULE_UNIQUE_PERSON_KEY__c = MULE_KEY
     ));
  }

  /** Test with creating a Name object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     insert objList;
     
     contactsList.add(new Contact(
         hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
         LastName = 'Smith'
     ));
     insert contactsList;
   
     ID batchprocessid = Database.executeBatch(myTestClass);
     
     
     // Getting the hud_Name to verify that the ‘Name_Contact__c’ field is not null
     objList = [
         SELECT Id, Name_Contact__c
         FROM hud_Name__c
         WHERE Id =:objList[0].Id
     ];
     
     Test.stopTest();
     
     // Verification
     System.assertEquals(contactsList[0].Id,
        [SELECT Id, Name_Contact__c FROM hud_Name__c WHERE Id = :objList[0].Id].Name_Contact__c);
   }
}