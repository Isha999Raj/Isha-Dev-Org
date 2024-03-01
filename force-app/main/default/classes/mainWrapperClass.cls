public class mainWrapperClass
{
    public wrapperClass wrapperobj {get;set;}  //initialization
    public List<wrapperClass> lstwrap {get;set;}
    public mainWrapperClass()      //constructor
    {
        lstwrap = New List<wrapperClass>();   //create object
        wrapperobj = New wrapperClass();      //create object
        wrapperobj.name = 'Isha Raj';
        wrapperobj.age = 20;
        wrapperobj.married = false;
        wrapperobj.height = 5.3;
        //system.debug(wrapperobj);
        
        wrapperClass wrapperobj1 = New wrapperClass();
        wrapperobj1.name = 'Anjali Singh';
        wrapperobj1.age = 22;
        wrapperobj1.married = false;
        wrapperobj1.height = 5.4;
        lstwrap.add(wrapperobj1);
        lstwrap.add(wrapperobj);
        system.debug('Detailes lists are : ' +lstwrap);
        
        /*wrapperClass wrapperobj2 = New wrapperClass(Name ='Vighnesh',age=24,married=true,height=5.10);
	    lstwrap.add(wrapperobj2);
	    system.debug(lstwrap);*/
        
        
    }
    
    public class wrapperClass         //wrapper class
    {
        public string name {get;set;}
        public integer age {get;set;}
        public boolean married {get;set;}
        public decimal height {get;set;}
    }
}