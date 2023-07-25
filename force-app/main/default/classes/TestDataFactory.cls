public with sharing class TestDataFactory {
    public static Account createAccount () {
        Account a = new Account(
            Name='Test'+Math.random()
        );
        insert a;
        return a;
    }

    public static Contact createContact (Account a) {
        Contact c = new Contact(
            AccountId = a.Id,
            FirstName = 'Test' + Math.random(),
            LastName = 'Test' + Math.random(),
            hud_MULE_UNIQUE_PERSON_KEY__c = 'Test' + Math.random()
        );
        insert c;
        return c;
    }
}