global  class ScheduleTweets implements  Schedulable{
    	global void execute(SchedulableContext SC) {
        	TrendTweets T=new TrendTweets();
            T.InsertData();
        }

}