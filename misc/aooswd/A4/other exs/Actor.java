   import java.util.*; 
   import java.io.*; 

   public class Actor extends Observable { 
   
      private String stateString = "idle"; 
   
      public Actor() { 
         addObserver(new Watcher()); 
      } 
   
      public String getState() { 
         return stateString; 
      } 
   
      public void setState(String s)  { 
         if( ! (s.equals(stateString) ) ) { 
            setChanged(); 
            notifyObservers("State changed"); 
         } 
         stateString = s; 
      } 
   
      public static void main(String[] args) { 
         String s; 
         Actor actor = new Actor(); 
         BufferedReader reader = 
         new BufferedReader(
                           new InputStreamReader(System.in)); 
         try { 
            System.out.println("Enter a state (" + 
                              actor.getState(
                                            ) + " is the current state): "); 
            while((s = reader.readLine()) != null) { 
               actor.setState(s); 
               System.out.println("Current state: " +
                                 actor.getState()); 
            } 
         } 
            catch(Exception e) { 
               System.out.println("Program terminated."); 
            } 
      } 
   } 


   class Watcher implements Observer { 
      public void update(Observable o, Object arg) { 
         System.out.println("Observable object " +
                           o + " has changed state."); 
      } 
   } 
