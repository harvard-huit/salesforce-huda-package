@isTest
private class HUDNameToUpdateAccountsBatchTest {

    public static List<Contact> contactsList;
    public static List<Account> objList;

    public static HUDNameToUpdateAccountsBatch myTestClass;

    static void init(){
        myTestClass = new HUDNameToUpdateAccountsBatch();
        myTestClass.email='testBatch@harvard.edu';

        contactsList = new List<Contact>();
        objList = new List<Account>();

        objList.add(new Account(
            Name = 'test',
            RecordTypeId = [select Id from RecordType where SobjectType = 'Account' and Name = 'Administrative' and IsActive = true][0].Id
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
        System.assertEquals(objList[0].Name, 'mylastname Account');

    }

    static testMethod void shouldNotOverwriteNonAdministrativeAccount () {
        // this could happen if an account for a cleaning vendor was already in the system
        // and the HUD load was performed and a contact was merged and the hud id is now
        // on a contact under the old cleaning vendor account
        

        // given an account that is not record type Administrative (not from our data load)
        Account testAccount = TestDataFactory.createAccount();
        String originalAccountName = String.valueOf(testAccount.Name);
        testaccount.RecordTypeId = [select Id from RecordType where SobjectType = 'Account' and DeveloperName = 'Business_Organization' and IsActive = true][0].Id;
        update testAccount;
        
        // and a new contact with a HUD id
        Contact testContact = TestDataFactory.createContact(testAccount);

        Test.startTest();
        
        // when we run our batch job
        Database.executeBatch(new HUDNameToUpdateAccountsBatch());

        Test.stopTest();

        // then it should not have replaced the name of our existing account
        System.assertEquals(originalAccountName, [select Name from Account where Id = :testAccount.Id].Name);

    }
}