public class AuthCallout {

       public void basicAuthCallout(){
       
       String keyencoded = EncodingUtil.urlEncode('MmccIbBG5svYJGSIYGIModig8','UTF-8');
    
    String secretkeyencoded = EncodingUtil.urlEncode('OowK3F6YlaENsX8o4tXHWLSFYFi5LLX1Fbq4BOiJnCSmIkcvmA', 'UTF-8');
    
    String sFinal = keyencoded + ':' + secretkeyencoded;
    
    Blob headerValue = Blob.valueOf(sFinal);

     HttpRequest req = new HttpRequest();

     req.setEndpoint('https://api.twitter.com/1.1/users/lookup.json?screen_name=britishboyindc,salesforce');

     req.setMethod('GET');

      

     // Specify the required user name and password to access the endpoint

     // As well as the header and header information

  

    

   

   

     String authorizationHeader = 'BASIC ' +

     EncodingUtil.base64Encode(headerValue);

     req.setHeader('Authorization', authorizationHeader);

  

     // Create a new http object to send the request object

     // A response object is generated as a result of the request 

 

     Http http = new Http();

     HTTPResponse res = http.send(req);
     System.debug('Here is the responce'+res.getBody());

   }


}