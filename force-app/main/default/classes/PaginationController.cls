public class PaginationController {
@AuraEnabled
    public static ContactPageWrapper showContacts(Decimal pageNumber ,Integer recordToDisply){
        Integer pageSize = recordToDisply;
     	 Integer offset = ((Integer)pageNumber - 1) * pageSize;
        ContactPageWrapper obj =new ContactPageWrapper();
        obj.pageSize = pageSize;
        obj.page = (Integer) pageNumber;
        obj.total = [SELECT count() FROM Contact];     
        obj.contacts = [Select Id, Name, Title, Email, MobilePhone, Fax, AccountId From Contact LIMIT: recordToDisply OFFSET :offset];
        return obj;
    }
    public class ContactPageWrapper
    {
    @AuraEnabled public Integer pageSize {get;set;}
    @AuraEnabled public Integer page {get;set;}
    @AuraEnabled public Integer total {get;set;}
    @AuraEnabled public List<Contact> contacts {get;set;}
    }
    @AuraEnabled
 public static ContactPageWrapper SearchAccount(Decimal pageNumber ,Integer recordToDisply,String searchKeyWord) {
   Integer pageSize = recordToDisply;
   Integer offset = ((Integer)pageNumber - 1) * pageSize;  
  String searchKey = searchKeyWord + '%';
     ContactPageWrapper obj =new ContactPageWrapper();
     obj.pageSize = pageSize;
     obj.page = (Integer) pageNumber;
      obj.total = [SELECT count() FROM Contact where Name LIKE: searchKey];
   obj.contacts= [select Id, Name, Title, Email, MobilePhone, Fax, AccountId from Contact where Name LIKE: searchKey LIMIT: recordToDisply OFFSET :offset];

  return obj;
 }
}