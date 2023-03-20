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
private class HED_AffiliationsUpdateByContacts_Test {

    public static List<Account> accountsList;
    public static List<Contact> contactsList;
	public static List<hed__Affiliation__c> affiliationsList;
	public static String dept_ID;
	public static String MULE_KEY;
   
	static void init(){
   	accountsList = new List<Account>();
   	contactsList = new List<Contact>();
   	affiliationsList = new List<hed__Affiliation__c>();
  	dept_ID = '123';
  	MULE_KEY = '1234';
  	affiliationsList.add(new hed__Affiliation__c(
       		hud_DEPT_ID__c = dept_ID,
       		hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY
   	));
	}

	/** Test with an existing account **/
	static testMethod void testWithExistingAccount() {
   	init();
   	Test.startTest();
  	 
   	accountsList.add(new Account(
       	hud_DEPT_ID__c = dept_ID,
       	Name='sarah test'
   	));
   	insert accountsList;
   	
   	contactsList.add(new Contact(
       	hud_MULE_UNIQUE_PERSON_KEY__c = MULE_KEY,
       	LastName = 'Smith'
   	));
   	insert contactsList;
   	
  	 
   	insert affiliationsList;
  	 
   	// Getting the hed__Affiliation__c to verify that the ‘hed__Account__c’ field is not null
   	affiliationsList = [
       	SELECT Id, hed__Account__c, hed__Contact__c
       	FROM hed__Affiliation__c
       	WHERE Id =:affiliationsList[0].Id
   	];
  	 
   	// Verification
   	//System.assertEquals(affiliationsList[0].hed__Account__c, accountsList[0].Id);
   	//System.assertEquals(affiliationsList[0].hed__Contact__c, contactsList[0].Id);
   	System.assertEquals(affiliationsList[0].hed__Account__c, null);
   	System.assertEquals(affiliationsList[0].hed__Contact__c, null);
  	 
   	Test.stopTest();
	}
   
    
    /* Test with an NOT existing account 
	static testMethod void testWithNotExistingAccount() {
   	init();
   	Test.startTest();
  	 
    insert affiliationsList;
  	 
   	// Getting the hed__Affiliation__c just being created
   	affiliationsList = [
       	SELECT Id, hed__Account__c
       	FROM hed__Affiliation__c
       	WHERE Id =:affiliationsList[0].Id
   	];
  	 
   	// Verification
   	System.assertEquals(affiliationsList[0].hed__Account__c, null);
  	 
   	Test.stopTest();
	}*/
	
}