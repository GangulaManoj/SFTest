trigger AutoPopulateDependentField on Account (before insert) {
        public Map<String,List<String>> getFields=new Map<String,List<String>>();
        for(Account a:Trigger.new)
        {
            if(!String.isEmpty(a.CountryPick__c))
            {
                getFields=GetDynamicDpenedPickListLogic.getDependentOptionsImpl('Account','CountryPick__c','StatePick__c');
                for(String contry:getFields.keySet())
                {
                    if(contry == a.CountryPick__c && getFields.get(contry).size() == 1)
                    {
                        a.StatePick__c=getFields.get(contry)[0];
                    }
                }
                
                
            }
        }
}