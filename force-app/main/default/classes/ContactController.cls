public with sharing class ContactController {
	public static List<Contact> getContacts()
    {
        list<Contact> contacts=[select Id,Name,email,MailingStreet,LeadSource from contact];
        return contacts;
    }
}