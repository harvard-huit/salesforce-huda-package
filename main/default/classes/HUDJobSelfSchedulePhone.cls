/*
Scheduled job for updating the contact ID field for HUDA  Phone
every day for the orphan objects.
*/
global class HUDJobSelfSchedulePhone implements Schedulable {
    public static String CRON_EXP = '0 01 * * * ?';

    global void execute( SchedulableContext SC )
        {   
            try{
                HUDPhonesUpdateByContacts myObj = new HUDPhonesUpdateByContacts ();
                myObj.runUpdate();

                HUDJobSelfSchedulePhone.start();

                // abort me and start again
                System.abortJob( SC.getTriggerId() );
            }
            catch (Exception e) {  
                HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
                Error_Log__c log = new Error_Log__c();
                
                log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
                
                log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
                + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
                + 'Class Name: ' + 'HUDPhonesUpdateByContacts in scheduled job';
                insert log;   
            }
        }

        public static void start()
        {
            // start keepalive again in 3600 seconds
            Datetime sysTime = System.now().addSeconds(3600);      
            String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
            System.schedule( 'Self Schedule Phone Mapping  ' + sysTime, chronExpression, new HUDJobSelfSchedulePhone() );
        }

}