public class MainPage {
    public list<contact> listcontact{get;set;}
    public Mainpage()
    {
        listcontact=new List<contact>();
        listcontact=[select id,name,Description,MailingCity from contact limit 5];
    }
    
}