trigger OnlyOwnerCanUpdate on Account (before update) {
        List<Account> AccList=trigger.new;
        List<Account> NewList=new List<Account>();
        for(Account a : AccList)
        {
            if(a.RecordTypeId == '0127F000000RYXTQA4')
            {
                if(a.OwnerId <> UserInfo.getUserId())
                {
                    a.addError('Only Owner Can Able to update the Record');
                }
                else
                {
                    NewList.add(a);
                }
            }
        }
    update NewList;
}