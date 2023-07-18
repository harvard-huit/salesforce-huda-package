public with sharing class JobAdmin {
    public JobAdmin() {
        
    }


	public void runAddressesUpdateByContactsBatch () {
		HUDAddressesUpdateByContactsBatch batchJob = new HUDAddressesUpdateByContactsBatch();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}
	
	public void runEmailsUpdateByContactsBatch () {
		HUDEmailsUpdateByContactsBatch batchJob = new HUDEmailsUpdateByContactsBatch();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}
	
	public void runNamesUpdateByContactsBatch1 () {
		HUDNamesUpdateByContactsBatch batchJob = new HUDNamesUpdateByContactsBatch();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}
	
	public void runNamesUpdateByContactsBatch2 () {
		HUDNameToUpdateContactsBatch  batchJob = new HUDNameToUpdateContactsBatch();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}
	
	public void runNamesUpdateByContactsBatch3 () {
		HUDNameToUpdateAccountsBatch  batchJob = new HUDNameToUpdateAccountsBatch();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}
	
	public void runLocationsUpdateByContactsBatch () {
		HUDLocationsUpdateByContactsBatch  batchJob = new HUDLocationsUpdateByContactsBatch ();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}
	
	public void runPhonesUpdateByContactsBatch () {
		HUDPhonesUpdateByContactsBatch  batchJob = new HUDPhonesUpdateByContactsBatch ();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}
	
	public void runAffiliationsUpdateByContactsBatch() {
		HED_AffiliationsUpdateByContactsBatch  batchJob = new HED_AffiliationsUpdateByContactsBatch ();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}
	
	public void runAffiliationsUpdateByAccountsBatch() {
		HED_AffiliationsUpdateByAccountsBatch  batchJob = new HED_AffiliationsUpdateByAccountsBatch ();
		
		if (!Test.isRunningTest()) Database.executeBatch(batchJob);
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Job started'));
	}

    //self scheduled jobs
    public void runContactsLastnamesRemapping() {
        System.schedule('HUDJobSelfNameToUpdateContactForEPPN',  '0 0 16 * * ?', new HUDJobSelfNameToUpdateContactForEPPN());
    }
    
    public void runContactsNamesRemapping() {
        System.schedule('HUDJobSelfScheduleNameToUpdateContact',  '0 0 17 * * ?', new HUDJobSelfScheduleNameToUpdateContact());
    }
    
    
    public void runAccountNamesRemapping() {
        System.schedule('HUDJobSelfScheduleNameToUpdateAccount',  '0 01 02 * * ?', new   HUDJobSelfScheduleNameToUpdateAccount());
        
    }
    
    public void runContactsEmailsRemapping() {
        System.schedule('HedJobContactEmailUpdate',  '0 02 02 * * ?', new HedJobContactEmailUpdate());
        
    }
    
    //orphan objects mapping
    
    public void runNewAddressMapping() {
        System.schedule('HUDJobSelfScheduleAddress',  '0 0 16 * * ?', new HUDJobSelfScheduleAddress());
    }
    
    public void runNewEmailMapping() {
        System.schedule('HUDJobSelfScheduleEmail',  '0 0 16 * * ?', new HUDJobSelfScheduleEmail());
    }
    
    public void runNewNameMapping() {
        System.schedule('HUDJobSelfScheduleName',  '0 0 16 * * ?', new HUDJobSelfScheduleName());
    }
    
    public void runNewLocationMapping() {
        System.schedule('HUDJobSelfScheduleLocation',  '0 0 16 * * ?', new HUDJobSelfScheduleLocation());
    }
    
    public void runNewPhoneMapping() {
        System.schedule('HUDJobSelfSchedulePhone',  '0 0 16 * * ?', new HUDJobSelfSchedulePhone());
    }
    
    public void runNewAffiliationMapping() {
        System.schedule('HEDJobSelfScheduleAffiliation',  '0 0 16 * * ?', new HEDJobSelfScheduleAffiliation());
    }
    
    
}