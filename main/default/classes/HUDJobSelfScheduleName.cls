/*
Scheduled job for updating the contact ID field for HUDA  Name
every day for the orphan objects.
*/
@Deprecated
global class HUDJobSelfScheduleName implements Schedulable {
    // public static String CRON_EXP = '0 01 * * * ?';

   global void execute( SchedulableContext SC )
        {        
            try{           
           	HUDNamesUpdateByContactsBatch myObj = new HUDNamesUpdateByContactsBatch();
            myObj.email='HUIT_Salesforce@harvard.edu';
            ID batchprocessid = Database.executeBatch(myObj);
           
           /////////////////////////////////// 
           //test saving error log and email alert
           //HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
           //Error_Log__c log = new Error_Log__c();
           //log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
           //log.trace__c = 'Type:  sarah test';
           //insert log;   
           ///////////////////////////////////

           HUDJobSelfScheduleName.start();

            // abort me and start again
            System.abortJob( SC.getTriggerId() );
            }

            catch (Exception e) {  
            	HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
                Error_Log__c log = new Error_Log__c();
                
                log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
            
                log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
            
                + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
            
                + 'Class Name: ' + 'HUDNamesUpdateByContacts in scheduled job';
            
                insert log;   
            
            }
        }

        public static void start()
        {
            // start keepalive again in 3600 seconds
            Datetime sysTime = System.now().addSeconds(3600);      
            String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
            System.schedule( 'Self Schedule Name Mapping ' + sysTime, chronExpression, new HUDJobSelfScheduleName() );
        }
}