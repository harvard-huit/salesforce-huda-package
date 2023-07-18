/*
Scheduled job for updating the name of the account by related contact's last name

*/
@Deprecated
global class HUDJobSelfScheduleNameToUpdateAccount implements Schedulable {
  // public static String CRON_EXP = '0 01 * * * ?';

   global void execute( SchedulableContext SC )
        {        
      try{
           //calling batch process
           HUDNameToUpdateAccountsBatch myObj = new HUDNameToUpdateAccountsBatch ();
           myObj.email='HUIT_Salesforce@harvard.edu';
           ID batchprocessid = Database.executeBatch(myObj);
           
           /*
           //start another new job
           HUDJobSelfScheduleNameToUpdateContact.start();

            // abort me and start again
            System.abortJob( SC.getTriggerId() );
            */
            }

      catch (Exception e) {  
      
           HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
           Error_Log__c log = new Error_Log__c();
                
           log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
      
          log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
      
          + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
      
          + 'Class Name: ' + 'HUDJobSelfScheduleNameToUpdateAccount in scheduled job';
      
          insert log;   
      
      }
        }

        public static void start()
        {
        /*
            // start keepalive again in 1200 seconds
            Datetime sysTime = System.now().addSeconds( 1200 );      
            String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
            System.schedule( 'HUDJobSelfScheduleNameToUpdateAccount ' + sysTime, chronExpression, new HUDJobSelfScheduleNameToUpdateAccount() );
            */
        }

}