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
private class HUDNameToUpdateContactsBatchTest {

  public static List<Contact> contactsList;
  public static List<hud_Name__c> objList;
  public static String MULE_KEY;
  public static HUDNameToUpdateContactsBatch myTestClass;
   
  static void init(){
     myTestClass = new HUDNameToUpdateContactsBatch();
     //myTestClass.email='testBatch@harvard.edu';
     
     contactsList = new List<Contact>();
     objList = new List<hud_Name__c>();
     MULE_KEY = 'abcdefg';
     objList.add(new hud_Name__c(
           NAME_LAST__c = 'namelast@harvard.edu',
           NAME_FIRST__c = 'namefirst@harvard.edu',
           MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
           NAME_TYPE__c='LISTING',
           eff_status__c ='A'
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
    
     Test.stopTest();
     
     contactsList = [
         SELECT Id, FirstName, LastName 
         FROM Contact
         WHERE Id =:contactsList[0].Id
     ];
     
     // Verification
     System.assertEquals(contactsList[0].FirstName, 'namefirst@harvard.edu');
     System.assertEquals(contactsList[0].LastName, 'namelast@harvard.edu');
   }
}