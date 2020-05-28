public with sharing class CreateContact {
        @AuraEnabled
		public static String CreateRecord(Contact con)
        {
            System.debug('Continfo'+con);
            try
            {
                if(con !=null)
                {
                    insert con;
                    system.debug('Success');
                    return 'success';
                }
            }catch(Exception e)
            {
				System.debug('Exception');                
            }
            return null;
        }
}