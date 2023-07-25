@isTest
public class myTest_Test {
public static testMethod void myTestControllerTest() {
        PageReference pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);

        myTestController controller = new myTestController();
        String nextPage = controller.emailUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdate'));
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.addressUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdate'));
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.nameUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdate'));
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.locationUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdate'));
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.phoneUpdate().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdate'));
        
        
        
        pageRef = Page.myTest;
        Test.setCurrentPage(pageRef);
        nextPage = controller.affiliationUpdateContact().getUrl();

        // Verify 
        System.assert(nextPage.contains('ConfirmationOfHUDUpdate'));

    }
}