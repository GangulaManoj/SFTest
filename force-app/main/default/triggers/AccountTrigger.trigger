trigger AccountTrigger on Account (before insert,before update) {

    map<String,Account> AccMap=new Map<String,Account>([select id,name,(select id from contacts) from Account where id iN: trigger.new]);
    List<Account> accList=new List<Account>();	
    List<Contact>  ConList=new List<Contact>();
    for(Account acc:Trigger.New)
        {
            Contact con=new Contact(FirstName='Test contact',LastName='Test');
            if(acc.contacts.size()>=1)
            {
                acc.addError('Error Multiple Contacts');
                System.debug('Error Multiple Contacts');
            }
            else
            {
               	con.AccountId=acc.id;
                ConList.add(con);
                accList.add(acc);
            }
        }
    //insert accList;
    insert ConList;
}