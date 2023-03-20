/*
Scheduled job for updating the contact ID field for HED_Affiliation
every day for the orphan objects.
*/
global class HEDJobSelfScheduleAffiliation implements Schedulable {
    public static String CRON_EXP = '0 5 * * * ?';

   global void execute( SchedulableContext SC )
        {        
            try{
           // do whatever it is you want to do here
           HED_AffiliationsUpdateByContacts myObj1 = new HED_AffiliationsUpdateByContacts ();
           myObj1.runUpdate();

            HEDJobSelfScheduleAffiliation.start();

            // abort me and start again
            System.abortJob( SC.getTriggerId() );
            }

            catch (Exception e) {  
            
                HUD_GlobalVariables myGlobal = new HUD_GlobalVariables();
            
                Error_Log__c log = new Error_Log__c();
                
                log.EmailReceiver__c = myGlobal.getEmailAlertEmailbox();
            
                log.trace__c = 'Type: ' + e.getTypeName() + '\n' + 'Cause: ' + e.getCause() + '\n' + 'Message: ' 
            
                + e.getMessage() + '\n' + 'Line #: ' + e.getLineNumber() + '\n' + e.getStackTraceString() + '\n'
            
                + 'Class Name: ' + 'HEDJobSelfScheduleAffiliation in scheduled job';
            
                insert log;   
            
            }
        }

        public static void start()
        {
            // start keepalive again in 3600 seconds
            Datetime sysTime = System.now().addSeconds(3600);      
            String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
            System.schedule( 'Self Schedule Affiliation Mapping ' + sysTime, chronExpression, new HEDJobSelfScheduleAffiliation() );
        }

}