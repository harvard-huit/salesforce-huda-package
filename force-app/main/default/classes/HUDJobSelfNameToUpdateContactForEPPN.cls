@Deprecated
global class HUDJobSelfNameToUpdateContactForEPPN implements Schedulable {
  // public static String CRON_EXP = '0 01 * * * ?';

   global void execute( SchedulableContext SC )
        {        
      try{
           //calling batch process
           HUDNameToUpdateContactsForEPPNBatch myObj = new HUDNameToUpdateContactsForEPPNBatch();
           myObj.email='HUIT_Salesforce@harvard.edu';
           ID batchprocessid = Database.executeBatch(myObj);
           
           
           //start another new job
           HUDJobSelfNameToUpdateContactForEPPN.start();

            // abort me and start again
            System.abortJob( SC.getTriggerId() );
            }

      catch (Exception e) {  
      
           HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
           Error_Log__c log = new Error_Log__c();
                
           log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
      
          log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
      
          + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
      
          + 'Class Name: ' + 'HUDJobSelfNameToUpdateContactForEPPN in scheduled job';
      
          insert log;   
      
      }
        }

        public static void start()
        {
            // start keepalive again in 600 seconds
            Datetime sysTime = System.now().addSeconds( 600 );      
            String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
            System.schedule( 'HUDJobSelfNameToUpdateContactForEPPN' + sysTime, chronExpression, new HUDJobSelfNameToUpdateContactForEPPN() );
        }

}