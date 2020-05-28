trigger AccountDeletion on Account (before update) {
   
    List<Account> acclist=new List<Account>();
    for(Account a : [select id from Account where id In (select Accountid from Opportunity) And id In : Trigger.New])
    {
        Trigger.NewMap.get(a.id).addError('We cant del' );
        acclist.add(a);
    }
	update acclist;
}