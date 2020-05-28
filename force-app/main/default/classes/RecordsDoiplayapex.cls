public class RecordsDoiplayapex {
 public List<wrapperClass> WrapperList{get;set;}
    public  List<Contact> ConList{get;set;}
    public Integer Count=0;
    public RecordsDoiplayapex()
    {
        getContactsList(); 
    }
    public  List<wrapperClass> getContactsList()
    {
        WrapperList=new List<wrapperClass>();
        List<Contact> cList=[select name,phone,email,Fax,DoNotCall from contact limit 10];
        for(Contact c:cList)
        {
            wrapperClass w=new wrapperClass();
            w.selected=false;
            w.ContactRecord=c;
            WrapperList.add(w);
        }
        return WrapperList;
    }
    public List<Contact> getContactsMethod()
    {
         ConList=new List<Contact>();
        for(wrapperClass w:WrapperList)
        {
            if(w.selected==true)
            {
            ConList.add(w.ContactRecord);
            }
        }
        Count++;
        System.debug('List'+ConList);
        return ConList;
    }
    public PageReference functioncall()
    {
        system.debug('In functioncall');
        getContactsMethod();
        return null;
        
    }
    public class wrapperClass
    {
        public boolean selected{get;set;}
        public Contact ContactRecord{get;set;}
    }
}