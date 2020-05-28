public class AccountExtension{
    
    public Id accid{get;set;}
    public Account acc{get;set;}
    public List<Contact> cont{get;set;}
    public List<Opportunity> oList{get;set;}
     public List<Case> cases{get;set;}
    public AccountExtension(ApexPages.StandardController controller) {
       
        accid=ApexPages.currentPage().getparameters().get('id');
        
    }   
   public List<Contact> getContactList()
   {
    cont=[select id,name,email,phone,fax from contact where AccountId =:accid];
  
   return cont;
   }
    public List<Opportunity> getOpptyList()
   {
    oList=[select Type,StageName,CloseDate,Amount from Opportunity where AccountId =:accid];
      System.debug(oList);
    return oList;
   }
    
     public List<Case> getCaseList()
   {
    cases=[select CaseNumber,Status,Priority,Origin,CreatedDate,ClosedDate,Subject from Case where AccountId =:accid];
  
    return cases;
   }
    
}