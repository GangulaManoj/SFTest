@isTest
public class TestRestrictContactByName {
     @isTest static void TestRestrictContact() {
        List<Contact> c=new List<Contact>();
         Contact con=new Contact(FirstName='Jnana',LastName='Deep',Email='test@mail.com');
         Contact con2=new Contact(FirstName='Jnana2',LastName='INVALIDNAME',Email='test2@mail.com');
         c.add(con);
         c.add(con2);
         Test.startTest();
         try
         {
         insert c;
         }
         catch(Exception e)
         {
             
         }
         Test.stopTest();
     }
    

}