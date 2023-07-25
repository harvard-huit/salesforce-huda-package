@isTest
public class myTestForBatch_test {
public static testMethod void myTestForBatchControllerTest() {
        PageReference pageRef = Page.myTestForBatch;
        Test.setCurrentPage(pageRef);

        myTestForBatchController controller = new myTestForBatchController();
        String nextPage = controller.emailUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdateForBatch'));
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.addressUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdateForBatch'));
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.nameUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdateForBatch'));
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.locationUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdateForBatch'));
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.phoneUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdateForBatch'));
        
        
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.affiliationUpdateContact().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdateForBatch'));

        
        
       

    }
}