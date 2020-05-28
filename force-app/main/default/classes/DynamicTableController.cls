public class DynamicTableController {

    public String DynamicQuery{get;set;}
    public List<sObject> dynamicList{get;set;} 
    public List<String> tString{get;set;}
    public DynamicTableController()
    {
       String ObjectName= ApexPages.currentPage().getParameters().get('obj');
       TablesColumns__c tc=TablesColumns__c.getValues(ObjectName);
       dynamicList=new List<sObject>();
        tString=tc.APIS__c.split(',');
        DynamicQuery='select '+tc.APIS__c+' from '+ObjectName;
        dynamicList=Database.query(DynamicQuery);
        System.debug('List of Records'+dynamicList);
    }
    public void renederingtest()
    {
        System.debug('Hi');
        String value=ApexPages.currentPage().getParameters().get('param1');
        System.debug('Value'+value);
    }
}