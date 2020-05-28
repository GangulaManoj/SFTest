global class SchedulableForTrendTweets implements Schedulable,Database.AllowsCallouts {
		global void execute(SchedulableContext SC) {
        	System.enqueueJob(new TrendTweetQuable());
            
        }

}