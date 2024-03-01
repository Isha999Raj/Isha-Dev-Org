public with sharing class CreateDisplayContact {

    @RemoteAction
    public static String createContact(string firstname, string lastname, string email){

        try{

            Contact conRec = New Contact(FirstName=firstname, LastName=lastname, Email=email);
            insert conRec;
            return conRec.Id;

        }catch (Exception e)
        {
            return e.getStackTraceString();
        }
    }

    @RemoteAction
    public static List<Contact> displayContact(){
            return [SELECT FirstName,LastName,Email FROM Contact];
    }
}