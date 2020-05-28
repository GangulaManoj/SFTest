public class ContactList {
    
    @AuraEnabled
	public static List<Contact> getContacts(Id accid)
    {
        return [select id,name,phone from contact where AccountId =:accid];
    }
     @AuraEnabled
	public static void InsertContacts(Contact Con)
    {
        insert con;
    }
}