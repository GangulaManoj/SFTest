public class TrendTweets {
    public UserDetails user{get;set;}
    public wrapperClass wrap{get;set;}
    public List<wrapperClass> Tweets{get;set;}
    public String queryString{get;set;}
    public Integer size{get;set;}
    public  Map<String,List<String>> FinalData{get;set;}
    public String currObj{get;set;}
    public List<chartClass> chart{get;set;}
    public List<Twitter_Tweets__b> Tobject{get;set;}
    public List<String> ListOfQueryStrings{get;set;}
    public TrendTweets()
    {
        Tobject=new List<Twitter_Tweets__b>();
         Tweets=new List<wrapperClass>();
       	chart=new List<chartClass>();
    }
    
    public String getBearerToken()
    {
        System.debug('In Bearer Token Mehod');
        //Encode them
        String keyencoded = EncodingUtil.urlEncode('MmccIbBG5svYJGSIYGIModig8', 'UTF-8');
        String secretkeyencoded = EncodingUtil.urlEncode('OowK3F6YlaENsX8o4tXHWLSFYFi5LLX1Fbq4BOiJnCSmIkcvmA', 'UTF-8');
        
        //Create Final Key String
        String sFinal = keyencoded + ':' + secretkeyencoded;
        //Convert to Blob
        Blob headerValue = Blob.valueOf(sFinal);
        //Build Request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twitter.com/oauth2/token');
        req.setMethod('POST');
        
        //Add Auth Header
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        
        //You need to add this to the request - proved easy to miss in instructions...
        req.setBody('grant_type=client_credentials');
        
        //Make request
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String stoken;
        //Parse JSON for Bearer Token
        System.debug('RESPONSE BODY'+res.getBody());
        JSONParser parser = JSON.createParser(res.getBody());
        
        while (parser.nextToken() != null) 
        {
            System.debug('Current Token'+parser.getCurrentToken()+'Access Token name'+parser.getText());
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'access_token')
            {
                parser.nextToken();
                stoken = parser.getText();
            }
        }
        //Return Token so it can be used in next call
        return stoken;
    }
    public void submittotwitter()
    {
        System.debug('In Submit to twitter');
        HttpRequest req2 = new HttpRequest();
      
         req2.setEndpoint('https://api.twitter.com/1.1/trends/place.json?id=1');
         req2.setMethod('GET'); 
         String authorizationHeader1 = 'Bearer ' + getBearerToken();
         req2.setHeader('Authorization', authorizationHeader1);
         Http http = new Http();
         HTTPResponse res = http.send(req2);
         String TBody =  res.getBody();
         JSONParser parser1 = JSON.createParser(res.getBody());
        integer i=0;
        Map<String,Object> obj1 =new Map<String,Object>();
        for(Object o:(List<Object>)JSON.deserializeUntyped(TBody))
        {
            obj1=(Map<String,Object>)o;
            System.debug('icount'+i+'In Loop '+obj1);
        }
         // transient Map<String,Object> obj1= ((Map<String,Object>)JSON.deserializeUntyped(TBody));  
         ListOfQueryStrings=new List<string>();
        if(obj1.containsKey('trends'))
        {
              List<Object> userList=(List<Object>)obj1.get('trends');
            	for(Object record:userList)
            	{
                    ListOfQueryStrings.add((String)((Map<String,Object>)record).get('query'));
                }
        }
        System.debug('list Size'+ListOfQueryStrings.size());
         integer cnt=1;
        for(integer j=0;j<5;j++)
        {
         cnt=cnt+j;
            System.debug('Test the link'+' '+'https://api.twitter.com/1.1/search/tweets.json?q='+ListOfQueryStrings[j]);
        req2=new HttpRequest();
        req2.setEndpoint('https://api.twitter.com/1.1/search/tweets.json?q='+ListOfQueryStrings[j]+'&count=200');
        req2.setMethod('GET');  
        String authorizationHeader = 'Bearer ' + getBearerToken();
        req2.setHeader('Authorization', authorizationHeader);
        http = new Http();
        res = http.send(req2);
         
        String sBody =  res.getBody();
            System.debug('Trends Body'+'    '+sBody);
        JSONParser parser2 = JSON.createParser(res.getBody());  
        transient Map<String,Object> obj2= (Map<String,Object>)JSON.deserializeUntyped(sBody);  
        Integer count=0;
        
        if(obj2.containsKey('statuses'))
        {
            List<Object> userList=(List<Object>)obj2.get('statuses');
            chartClass c=new chartClass(ListOfQueryStrings[j],userList.size());
            chart.add(c);
            for(Object record:userList)
            {
                wrap=new wrapperClass();
                //String messageName = (String)((Map<String,Object>)record).get('created_at');
                wrap.created_Date=(String)((Map<String,Object>)record).get('created_at');
                wrap.TweetId=(String)((Map<String,Object>)record).get('id_str');
                wrap.text=(String)((Map<String,Object>)record).get('text');
                System.debug('Smaple Test'+wrap.text);
                wrap.Source=(String)((Map<String,Object>)record).get('source');
                ++count;
                Map<String,Object> fieldsMap = (Map<String,Object>)(((Map<String,Object>)record).get('user'));
                UserDetails u=new UserDetails();
                if(fieldsMap.containsKey('id'))
                {
                    u.uid=(Long)fieldsMap.get('id');   
                }
                if(fieldsMap.containsKey('name'))
                {
                    u.UserName=String.valueOf(fieldsMap.get('name'));   
                }
                if(fieldsMap.containsKey('screen_name'))
                {
                    u.Screen_Name=String.valueOf(fieldsMap.get('screen_name'));   
                }
                if(fieldsMap.containsKey('location'))
                {
                    u.Location=String.valueOf(fieldsMap.get('location'));   
                }
                if(fieldsMap.containsKey('friends_count'))
                {
                    u.Frd_count=String.valueOf(fieldsMap.get('friends_count'));   
                }
                if(fieldsMap.containsKey('followers_count'))
                {
                    u.Follow_count=String.valueOf(fieldsMap.get('followers_count'));   
                }
                if(fieldsMap.containsKey('favourites_count'))
                {
                    u.favourites_count=String.valueOf(fieldsMap.get('favourites_count'));   
                }
                wrap.users=u;
               
                System.debug('Final Wrap Refernce'+wrap);
                Tweets.add(wrap);
                
            }
            
        }
        }
        System.debug('wrape Date'+Tweets.size());
        for(wrapperClass w:Tweets)
        {
            System.debug('wrape Date'+'     '+w.text);
        }
    }
    
    public List<chartClass> getPieData() {

        
        return chart;
    }

    public class PieWedgeData {
        public String name { get; set; }
        public Integer data { get; set; }
        public PieWedgeData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
   
    public class UserDetails
    {
        public Long uid{get;set;}
        public String UserName{get;set;}
        public String Screen_Name{get;set;}
        public String Location{get;set;}
        public String Frd_count{get;set;}
        public String Follow_count{get;set;}
        public String favourites_count{get;set;}
        
    }
    
    public class wrapperClass
    {
        public  String created_Date{get;set;}
        public String TweetId{get;set;}
        public String text{get;set;}
        public String Source{get;set;}
        public UserDetails users{get;set;}
    }
    public void InsertData()
    {
        submittotwitter();
        Tobject=new List<Twitter_Tweets__b>();
        for(wrapperClass w:Tweets)
        {
            Twitter_Tweets__b tw=new Twitter_Tweets__b();
            // System.debug('TweetID'+Integer.ValueOf(w.TweetId));
            tw.id__c=w.TweetId;
            tw.created_at__c=getdate(w.created_Date);
            tw.followers_count__c=Integer.ValueOf(w.users.Follow_count);
            tw.friends_count__c=Integer.ValueOf(w.users.Frd_count);
            tw.favourites_count__c=Integer.ValueOf(w.users.favourites_count);
            tw.location__c=w.users.Location;
            tw.name__c=w.users.UserName;
            tw.text__c=w.text;
            Tobject.add(tw); 
        }
        System.debug('In insert method'+Tobject);
      Database.insertImmediate(Tobject);
        
    }
    public class chartClass
    {
        public String TQuery{get;set;}
        public Integer NoOfTweets{get;set;}
		public chartClass(String TQuery,Integer NoOfTweets)
        {
            this.TQuery=TQuery;
            this.NoOfTweets=NoOfTweets;
        }
    }
    
    public date getdate(String myDate)
    {
        String strMnth    = myDate.substring(4,7);
        String day        = myDate.substring(8,10);
        String year       = myDate.substring(26,30);
        string strMonth ;
        if(strMnth=='Jan')
            strMonth ='01';
        else if (strMnth == 'Feb' )
            strMonth ='02';
        else if (strMnth == 'Mar' )
            strMonth ='03';
        else if (strMnth == 'Apr' )
            strMonth ='04';
        else if (strMnth == 'May' )
            strMonth ='05';
        else if (strMnth == 'Jun' )
            strMonth ='06';
        else if (strMnth == 'Jul' )
            strMonth ='07';
        else if (strMnth == 'Aug' )
            strMonth ='08';
        else if (strMnth == 'Sep' )
            strMonth ='09';
        else if (strMnth == 'Oct' )
            strMonth ='10';
        else if (strMnth == 'Nov' )
            strMonth ='11';
        else if (strMnth == 'Dec' )
            strMonth ='12';
        
        String strDate = strMonth +'/'+day+'/'+year;
        System.debug('------>'+strDate );
        date mydate1 = date.parse(strDate);
        System.debug('------>'+mydate1 );
        return mydate1;
    }

}