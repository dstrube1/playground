/*************
commands:

a command object for each potential operation on the data set
redo & undo commands
*************/

   class Command{
      private String op;
   
      public Command(){
         op="";
      }
   
      public Command (String operation){
         op=operation;
      }
   
      public Command (Command c){
         op=c.getOp();
      }
   
      public String getOp(){
         return op;
      }
   
      /*public void fillToN(int n, MyList dataset){
         Integer i=new Integer(0);
         for (int j=0; j<n; j++){
            i=new Integer(j);
            dataset.push(i);
         }
      }*/
   
      public void addNtoAll(int n, MyList dataset){
         Integer i=new Integer(0);
         int temp;
         for (int j=0; j<dataset.size(); j++){
            temp=dataset.get(j).intValue()+n;
            i=new Integer(temp);
            dataset.set(j, i);
         }
      }
   
      public void addNtoX(int n, int x, MyList dataset){
         int temp = dataset.get(x).intValue()+n;
         Integer i=new Integer(temp);
         dataset.set(x,i);
      }
   
      public void subNtoAll(int n, MyList dataset){
         Integer i=new Integer(0);
         int temp;
         for (int j=0; j<dataset.size(); j++){
            temp=dataset.get(j).intValue()-n;
            i=new Integer(temp);
            dataset.set(j, i);
         }
      }
   
      public void subNtoX(int n, int x, MyList dataset){
         int temp = dataset.get(x).intValue()-n;
         Integer i=new Integer(temp);
         dataset.set(x,i);
      }
   
      public boolean undo(Command c, MyList dataset){
      
         boolean result=false;
         if (c.getOp().matches("addTo.+")){
            result=true;
            if (c.getOp().matches("addToX, .+")){
               Integer n = new Integer( 
                              c.getOp().substring( 
                                                c.getOp().indexOf(',')+2, c.getOp().lastIndexOf(',') ) );
               Integer x = new Integer( 
                              c.getOp().substring( 
                                                c.getOp().lastIndexOf(',')+2 ) );
               c.subNtoX(n.intValue(), x.intValue(), dataset);
            }
            else if(c.getOp().matches("addToAll, .+")){
               Integer n = new Integer(c.getOp().substring(c.getOp().indexOf(',')+2));
               c.subNtoAll(n.intValue(), dataset);
            }	
         }
         else if( c.getOp().matches("subTo.+")){
            result=true;
            if (c.getOp().matches("subToX, .+")){
               Integer n = new Integer( 
                              c.getOp().substring( 
                                                c.getOp().indexOf(',')+2, c.getOp().lastIndexOf(',') ) );
               Integer x = new Integer( 
                              c.getOp().substring( 
                                                c.getOp().lastIndexOf(',')+2 ) );
               c.addNtoX(n.intValue(), x.intValue(), dataset);
            }
            else if(c.getOp().matches("subToAll, .+")){
               Integer n = new Integer(c.getOp().substring(c.getOp().indexOf(',')+2));
               c.addNtoAll(n.intValue(), dataset);
            }
         
         }
         return result;
      }
   
      public boolean redo(Command c, MyList dataset){
         boolean result=false; 
         if (c.getOp().matches("addTo.+") || c.getOp().matches("subTo.+")
            || c.getOp().matches("") )
            result=true; 
      
         return result;
      }
   
      public void print(MyList dataset){
         System.out.println(dataset.toString()+'\n');
      }
   
   }