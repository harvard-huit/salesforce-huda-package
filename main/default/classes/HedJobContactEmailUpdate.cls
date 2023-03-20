/*
Scheduled job for updating HILT Constituent data with Harvard Data once every day at 01:01.
*/
global class HedJobContactEmailUpdate implements Schedulable {

   public static String CRON_EXP = '0 01 01 * * ?';
   
   global void execute( SchedulableContext SC )
        {        
         try{
            Contact_EmailField_Update_Batch  myObj = new Contact_EmailField_Update_Batch();
            myObj.email='HUIT_Salesforce@harvard.edu';
            ID batchprocessid = Database.executeBatch(myObj);
          }
        catch (Exception e) {  
                HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
                Error_Log__c log = new Error_Log__c();
                
                log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
                
                log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
                + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
                + 'Class Name: ' + 'HedJobContactEmailUpdate in scheduled job';
                insert log;   
        }
        }

        
        public static void start()
        {
        }
}