trigger AddRelatedRecord on Account (after insert, after update) {
  List<Opportunity> ListOpp=new List<Opportunity>();
    Map<id,Account> AccListwithOpp=new Map<id,Account>([select id,(select id from Opportunities) from Account where id IN:Trigger.New]);
    for(Account a:Trigger.New)
    {
        if(AccListwithOpp.get(a.Id).Opportunities.size() == 0)
        {
            ListOpp.add(new Opportunity(Name=a.Name+' Opportunity',
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=a.Id));
        }
    }
    if(ListOpp.size()>0)
        insert ListOpp;
    
}