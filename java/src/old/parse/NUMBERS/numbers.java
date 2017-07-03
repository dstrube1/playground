   //http://java.sun.com/docs/books/tutorial/java/data/copyingarrays.html
   package numbers;
   public class numbers {
   	//non-padded:
      static String num0_9[]= new String[10]; 	
      static String num10_99[]= new String[90];
      static String num100_999[]= new String[900];
      //padded:
      static String num00_09[]= new String[10];
      static String num000_009[]= new String[10];
      static String num010_099[]= new String[90];
   
      public static String num0_99[]= new String[100]; //0-99
      public static String num00_99[]= new String[100]; //00-99
      public static String num000_999[]= new String[1000]; //000-999
      public numbers( ){
      //fill the dummies with their values
      
         padded0(num00_09,0);
         padded00(num000_009,0);
         padded00(num010_099,10);
      
         nonpadded(num0_9,0);
         nonpadded(num10_99,10);
         nonpadded(num100_999,100);
      
      //then paste them together into their mightier brothers
         System.arraycopy(num0_9, 0, num0_99, 0, num0_9.length); 
         System.arraycopy(num10_99, 0, num0_99, num0_9.length, num10_99.length); 
      
         System.arraycopy(num00_09, 0, num00_99, 0, num00_09.length);
         System.arraycopy(num10_99, 0, num00_99, num00_09.length, num10_99.length);
      
         System.arraycopy(num000_009, 0, num000_999, 0, num000_009.length); //10
         System.arraycopy(num010_099, 0, num000_999, num000_009.length, num010_099.length); //10, 90
         System.arraycopy(num100_999, 0, num000_999, num010_099.length+num000_009.length, num100_999.length); //90+10, 900
      
      //now print to test:
         //printArray(num0_99);
         //printArray(num00_99);
         //printArray(num000_999);
      }
   
      public static void printArray	( String temp[]){
         for(int a=0; a<temp.length; a++){
            System.out.print(temp[a]+ " ");
         }
         System.out.println();
      }
   
      public static void padded00( String temp[], int start){
         int plus;
         for (int k=0; k<temp.length; k++){ 
            plus=k+start;
            if (k<100){
               temp[k] = "0";
               if (plus<10)
                  temp[k] += "0";
            }
            temp[k] += plus;
         }
      
      }
   
      public static void padded0( String temp[], int start){
         int plus;
         for (int k=0; k<temp.length; k++){ 
            plus=k+start;
            if (k<10)
               temp[k] = "0";
            temp[k] += plus;
         }
      
      }
   
   
      public static void nonpadded( String temp[], int start){
         int plus;
         for (int i=0; i<temp.length; i++){
            plus = i+start;
            temp[i] = ""+plus;
         }
      }
   }