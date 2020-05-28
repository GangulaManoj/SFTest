public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(Integer num,String Lname)
    {
        List<Contact> Persons=new List<Contact>();
        for(Integer i=0;i<num;i++)
        {
            Contact c=new Contact(FirstName='Person'+i,LastName=Lname);
            Persons.add(c);
        }
		        return Persons;
    }

}