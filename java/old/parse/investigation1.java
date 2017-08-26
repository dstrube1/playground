// investigation1
// Created: 2003-1-3 330p
// http://java.sun.com/j2se/1.4/docs/api/
// simply out puts all urls investigated 
//so to narrow down the search manually,
// till i get smarter (TIGS)

   import numbers.*;

   public class investigation1
   {
      public static void main( String args[] )
      {
      	/****************************
      	//		Constants
      	****************************/
         final String domain = "http://kjdfbkljdnfb.com/rnd/img/";
         final String ending=".jpg";
         final String img_name[] = {"x"}; 
      
         /****************************
      	//		Variables
      	****************************/
         String urltext="";
         numbers n = new numbers();
      
         //int count=0;
         //boolean notfound = false;
      
         for (int h=0; h<img_name.length; h++){ //each img_name
            for (int i=0; i<3; i++){ //each number format
               if (i==0){
                  for(int j=0; j<n.num0_99.length;j++){
                     urltext = (domain + img_name[h] +n.num0_99[j]+ ending);
                     System.out.println(urltext);
                  }
               }
               else if (i==1){
                  for(int k=0; k<n.num00_99.length;k++){
                     urltext = (domain + img_name[h] +n.num00_99[k]+ ending);
                     System.out.println(urltext);}
               }	
               else{
                  for(int m=0; m<n.num000_999.length;m++){
                     urltext = (domain + img_name[h] +n.num000_999[m]+ ending);
                     System.out.println(urltext);
                  }
               }
            
            
            } //end cycling number formats
         } //end img_names
      } //close main
   } //close class
