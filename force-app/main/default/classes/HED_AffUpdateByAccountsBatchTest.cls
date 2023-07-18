@isTest(seeAllData=false)
private class HED_AffUpdateByAccountsBatchTest {

  public static List<Account> accountsList;
  public static List<hed__Affiliation__c> objList;
  public static String deptId;
  public static HED_AffiliationsUpdateByAccountsBatch myTestClass;
   
  static void init(){
     myTestClass = new HED_AffiliationsUpdateByAccountsBatch();
     myTestClass.email='testBatch@harvard.edu';
     
     accountsList = new List<Account>();
     objList = new List<hed__Affiliation__c>();
     deptId = 'abcdefg';
     
    
     objList.add(new hed__Affiliation__c(
           hud_DEPT_ID__c = deptId
     ));
  }

  /** Test with creating an Address object first and then creating a contact after **/
  static testMethod void test() {
     init();
     Test.startTest();
     
     insert objList;
     
      accountsList.add(new Account(
           name='test',
           hud_DEPT_ID__c = deptId
     ));
     insert accountsList;
   
     ID batchprocessid = Database.executeBatch(myTestClass);
     
     Test.stopTest();
     
     
     objList = [
         SELECT Id, hed__Account__c
         FROM hed__Affiliation__c
         WHERE Id =:objList[0].Id
     ];
     
     
     
     // Verification
     System.assertEquals(accountsList[0].Id, objList[0].hed__Account__c);
   }
}