@isTest
private class JobAdminTests {
	
	@isTest static void coverage () {
		JobAdmin controller = new JobAdmin();
		
		//batch jobs
		controller.runAddressesUpdateByContactsBatch();
		
		controller.runEmailsUpdateByContactsBatch();
		
		controller.runNamesUpdateByContactsBatch1();		
		controller.runNamesUpdateByContactsBatch2();		
		controller.runNamesUpdateByContactsBatch3();
		
		controller.runLocationsUpdateByContactsBatch();
		
		controller.runPhonesUpdateByContactsBatch();		
		
		controller.runAffiliationsUpdateByContactsBatch();
		controller.runAffiliationsUpdateByAccountsBatch();
		
		//daily jobs
		controller.runContactsLastnamesRemapping();
		controller.runContactsNamesRemapping();
		controller.runAccountNamesRemapping();
		controller.runContactsEmailsRemapping();
		
		controller.runNewAddressMapping();
		controller.runNewEmailMapping();
		controller.runNewNameMapping();
		controller.runNewLocationMapping();
		controller.runNewPhoneMapping();
		controller.runNewAffiliationMapping();
	}
}