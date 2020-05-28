@RestResource(urlMapping='/Account/*/contacts')
global class AccountManager 
{
    @HttpGet
    global static Account getAccount()
    {
        Restrequest request=RestContext.request;
        String accId=request.requestURI.substringBetween('Account/','/contacts');
        Account acc=[select id,name,(select id,name from contacts) from account where id=:accId];
        return acc;
    } 
}