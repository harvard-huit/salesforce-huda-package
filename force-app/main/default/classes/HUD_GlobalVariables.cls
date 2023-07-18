@Deprecated
public class HUD_GlobalVariables {
	  public  String getEmailAlertEmailbox()
        {
             List<GlobalVariable__c> objs = [select value__c  from GlobalVariable__c where name='Email Address for Email Alerts'];
             String myEmailaddress = objs[0].value__c;
             return myEmailaddress;
        }
    
}