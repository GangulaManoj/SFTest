public class Scontroller
{
        public String sBody{get;set;}
        public String tweets{get;set;}
        public String access_token {get;set;}
        public Scontroller()
        {   
            String keyencoded = EncodingUtil.urlEncode('MmccIbBG5svYJGSIYGIModig8','UTF-8');
            String secretkeyencoded = EncodingUtil.urlEncode('3300314300-pkJDv2OGe98QUbiWFwVENOxNtxKOUXoAXNXIQ2h', 'UTF-8');
            String sFinal = keyencoded + ':' + secretkeyencoded;
            Blob headerValue = Blob.valueOf(sFinal);
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.twitter.com/oauth2/token');
            req.setMethod('POST');
            String authorizationHeader = 'Basic' + EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader);
            req.setBody('grant_type=client_credentials');
            Http http = new Http();
            HTTPResponse res = http.send(req);

            JSONParser parser = JSON.createParser(res.getBody());
            while(parser.nextToken() != null)
            {
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME)
                {
                    String fieldName = parser.getText();
                    parser.nextToken();
                    if(fieldName == 'access_token')
                    {
                        access_token = parser.getText();
                    }

                }
            }


        }

        public String gettweetsss(){

            HttpRequest req2 = new HttpRequest();

                req2.setEndpoint('https://api.twitter.com/1.1/search/tweets.json?q=%23narendramodi&count=12');
                req2.setMethod('GET');

                //Call Bearer token Method
                String authorizationHeader = 'Bearer' + access_token;
                req2.setHeader('Authorization', authorizationHeader);

                Http http = new Http();
                HTTPResponse res = http.send(req2);

                tweets = res.getBody();
                return tweets;  
        }
 }