public class TwitterController2 {
    public UserDetails user{get;set;}
    public wrapperClass wrap{get;set;}
    public List<wrapperClass> Tweets{get;set;}
    public String queryString{get;set;}
    public Integer size{get;set;}
    public  Map<String,List<String>> FinalData{get;set;}
    public String currObj{get;set;}
    public List<Twitter_Tweets__b> Tobject{get;set;}
    
    public TwitterController2()
    {
        Tobject=new List<Twitter_Tweets__b>();
       
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
        req2.setEndpoint('https://api.twitter.com/1.1/search/tweets.json?q=%23'+queryString);
        req2.setMethod('GET');  
        String authorizationHeader = 'Bearer ' + getBearerToken();
        req2.setHeader('Authorization', authorizationHeader);
        Http http = new Http();
        HTTPResponse res = http.send(req2);
        String sBody =  res.getBody();
        JSONParser parser = JSON.createParser(res.getBody());  
        transient Map<String,Object> obj= (Map<String,Object>)JSON.deserializeUntyped(sBody);  
        Integer count=0;
        Tweets=new List<wrapperClass>(); 
        if(obj.containsKey('statuses'))
        {
            List<Object> userList=(List<Object>)obj.get('statuses');
            for(Object record:userList)
            {
                wrap=new wrapperClass();
                //String messageName = (String)((Map<String,Object>)record).get('created_at');
                wrap.created_Date=(String)((Map<String,Object>)record).get('created_at');
                wrap.TweetId=(String)((Map<String,Object>)record).get('id_str');
                wrap.text=(String)((Map<String,Object>)record).get('text');
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
                Tweets.add(wrap);
                
            }
            System.debug('wrape Date'+Tweets);
        }
    }
    
    public List<wrapperClass> getPieData() {
System.debug('In getPidata');
        List<wrapperClass> data = new List<wrapperClass>();
/*
        data.add(new wrapperClass('Jan', 30));

        data.add(new PieWedgeData('Feb', 15));

        data.add(new PieWedgeData('Mar', 10));

        data.add(new PieWedgeData('Apr', 20));

        data.add(new PieWedgeData('May', 20));

        data.add(new PieWedgeData('Jun', 5));*/
      //  wrapperClass w=new wrapperClass();
     //   w.TweetId='1'+' '+2;
	//data.add(w);
        System.debug('In getPidata'+Tweets);
        return Tweets;
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