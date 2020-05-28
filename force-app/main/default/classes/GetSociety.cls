public class GetSociety {
 @auraEnabled
    public static List<Account> GetAcc()
    {
        List<Account> acc=new LIST<Account>();  
        acc=[select Name,secretary__c,BillingCity,BillingState,BillingStreet,BillingCountry from Account];
		System.debug('In acc'+acc);
        return acc; 
    } 
}