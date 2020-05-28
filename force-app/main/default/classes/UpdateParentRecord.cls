public class UpdateParentRecord implements queueable{
    private List<Account> accounts;
    private ID parent;
	public UpdateParentRecord(List<Account> records,ID id)
    {
        this.accounts=records;
        this.parent=id;
    }
    public void execute(QueueableContext context)
    {
        for(Account account:accounts){
            account.parentId=parent;
        }
        update accounts;
    }

}