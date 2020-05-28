@RestResource(urlMapping='/secureApexRest')
global with sharing class SecureApexRest {
    @HttpGet
    global static Contact doGet(){
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        try
        {
         if (recordId == null){
            throw new FunctionalException('Id parameter is required');
        }
            List<Contact> results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId with security_enforced];
            if (!results.isEmpty()) {
                result = results[0];
            }
        
           
        }
        catch(System.QueryException e)
        {
         	system.debug('Exception Details'+e.getMessage());
        }
        
        return result;
    }
    public class FunctionalException extends Exception{}
    public class SecurityException extends Exception{}
}