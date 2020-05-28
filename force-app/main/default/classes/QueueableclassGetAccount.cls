public class QueueableclassGetAccount implements Queueable {

    public String AccountName;
    public QueueableclassGetAccount(String Acc)
    {
        this.AccountName=Acc;
    }
    public void execute(QueueableContext context)
    {
     	Account Acc=[select id,Name from Account where id=:AccountName];   
        System.debug('Account Details Are'+Acc);
    }
}