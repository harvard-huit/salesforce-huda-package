/*
Scheduled job for updating the contact firstname and lastname by hud_name

*/
global class HUDJobSelfScheduleNameToUpdateContact implements Schedulable {
  // public static String CRON_EXP = '0 01 * * * ?';

   global void execute( SchedulableContext SC )
        {        
      try{
           //calling batch process
           HUDNameToUpdateContactsBatch myObj = new HUDNameToUpdateContactsBatch ();
           ID batchprocessid = Database.executeBatch(myObj);
           
           
           //start another new job
           HUDJobSelfScheduleNameToUpdateContact.start();

            // abort me and start again
            System.abortJob( SC.getTriggerId() );
            }

      catch (Exception e) {  
      
           HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
           Error_Log__c log = new Error_Log__c();
                
           log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
      
          log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
      
          + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
      
          + 'Class Name: ' + 'HUDJobSelfScheduleNameToUpdateContact in scheduled job';
      
          insert log;   
      
      }
        }

        public static void start()
        {
            // start keepalive again in 18000 seconds
            Datetime sysTime = System.now().addSeconds( 18000 );      
            String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
            System.schedule( 'Self Schedule Name to update contact ' + sysTime, chronExpression, new HUDJobSelfScheduleNameToUpdateContact() );
        }

}