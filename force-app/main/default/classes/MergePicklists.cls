public class MergePicklists {
    public String TestPick{get;set;}
    public List<SelectOption> options{get;set;}
	public MergePicklists()
    {
       options= new List<SelectOption>();
        getPicklistValues(new Account(),'Type',new Opportunity(),'Type');
    }
   public  list<SelectOption> getPicklistValues(SObject obj1,String field,SObject obj2,String field2)
    {
        
        Schema.SObjectType objType=obj1.getSObjectType();
        Schema.DescribeSObjectResult objDesc=objType.getDescribe();
        Map<String,Schema.SObjectField> fieldsMap=objDesc.fields.getMap();
        List<Schema.PicklistEntry> values=fieldsMap.get(field).getDescribe().getPickListValues();
        for(Schema.PicklistEntry s:values)
        {
            options.add(new SelectOption(s.getLabel(),s.getValue()));
        }
        System.debug('Values'+options);
        objType=obj2.getSObjectType();
        objDesc=objType.getDescribe();
        fieldsMap=objDesc.fields.getMap();
        values=fieldsMap.get(field2).getDescribe().getPickListValues();
        for(Schema.PicklistEntry s:values)
        {
            options.add(new SelectOption(s.getLabel(),s.getvalue()));
        }
        System.debug('Values'+options);
        return options;
    }
}