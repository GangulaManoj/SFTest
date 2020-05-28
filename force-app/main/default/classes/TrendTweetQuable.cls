public class TrendTweetQuable implements Queueable,Database.AllowsCallouts {
    
    public void execute(QueueableContext context){
        TrendTweets T=new TrendTweets();
            T.InsertData();
    }

}