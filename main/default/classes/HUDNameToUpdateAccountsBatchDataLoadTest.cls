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
private class HUDNameToUpdateAccountsBatchDataLoadTest {
  public static List<Contact> contactsList;
  public static List<Account> objList;
  
  public static HUDNameToUpdateAccountsBatchDataLoad myTestClass;
   
  static void init(){
     myTestClass = new HUDNameToUpdateAccountsBatchDataLoad();
     myTestClass.email='testBatch@harvard.edu';
     
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
         LastName = 'mylastname',
         hud_MULE_UNIQUE_PERSON_KEY__c = '123'
     ));
     insert contactsList;
   
     ID batchprocessid = Database.executeBatch(myTestClass);
    
     Test.stopTest();
     
     objList = [
         SELECT Id, Name  
         FROM Account
         WHERE Id =:objList[0].Id
     ];
     
     // Verification
     System.assertEquals('mylastname Account', objList[0].Name);
    
   }
}