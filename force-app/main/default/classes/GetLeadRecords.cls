public class GetLeadRecords {
 @auraEnabled
    public static List<Lead> GetLeads()
    {
        List<Lead> reg=new LIST<Lead>();  
        reg=[select id,FirstName,Status from Lead];

        return reg; 
    } 
}