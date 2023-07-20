/*
Scheduled job for updating the contact ID field for HUDA  address
every day for the orphan objects.
*/
global class HUDJobSelfSchedule implements Schedulable {
    public static String CRON_EXP = '0 01 * * * ?';

   global void execute( SchedulableContext SC )
        {        

            try{
                // do whatever it is you want to do here
                HUDAddressesUpdateByContacts myObj1 = new HUDAddressesUpdateByContacts ();
                myObj1.runUpdate();
           
                HUDEmailsUpdateByContacts myObj2 = new HUDEmailsUpdateByContacts ();
                myObj2.runUpdate();
                
                //dev testing
                //Error_Log__c log = new Error_Log__c();
                //log.trace__c = 'Type: Sarah Testing';
                //insert log;
                //end of testing

                HUDJobSelfSchedule.start();

                // abort me and start again
                System.abortJob( SC.getTriggerId() );
            }
            catch (Exception e) {  
                Error_Log__c log = new Error_Log__c();
                log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
                + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
                + 'Class Name: ' + 'HUDEmailsUpdateByContacts in scheduled job';
                insert log;   
            }
        }

        public static void start()
        {
            // start keepalive again in 30 seconds
            Datetime sysTime = System.now().addSeconds( 30 );      
            String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
            System.schedule( 'SelfSchedule ' + sysTime, chronExpression, new HUDJobSelfSchedule() );
        }

}