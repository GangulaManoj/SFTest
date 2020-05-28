public class PageBlockWithoutBorders {
    public boolean selected{get;set;}
	public PageBlockWithoutBorders()
    {
        selected=true;
    }
    public List<Account> getAcc()
    {
        return [select id,name,NumberOfEmployees,Phone from Account];
    }
    
}