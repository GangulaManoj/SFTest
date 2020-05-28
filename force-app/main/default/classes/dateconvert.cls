public class dateconvert {
    public void getdate()
    {
 String myDate = 'Sun Dec 05 17:04:33 +0000 2017';
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
    }
    public static void insertT()
    {
        Hive__b t = new Hive__b();
        t.x_expectation__c = '12345';
        t.y_prediction__c = '1111';
        System.debug(Database.insertImmediate(t));
    }
}