   import java.net.*;
   import java.io.*;
   import java.util.*;

   public class jhttp extends Thread {
   
      Socket theConnection;
      static File docroot;
      static String indexfile = "index.html";
   
      public jhttp(Socket s) {
         theConnection = s;
      }
   
      public static void main(String[] args) {
      
         int thePort;
         ServerSocket ss;
      
      // get the Document root
         try {
            docroot = new File(args[0]);
         }
            catch (Exception e) {
               docroot = new File(".");
            }
      
      // set the port to listen on
         try {
            thePort = Integer.parseInt(args[1]);
            if (thePort < 0 || thePort > 65535) thePort = 80;
         }  
            catch (Exception e) {
               thePort = 80;
            }  
      
         try {
            ss = new ServerSocket(thePort);
            System.out.println("Accepting connections on port " 
                              + ss.getLocalPort());
            System.out.println("Document Root:" + docroot);
            while (true) {
               jhttp j = new jhttp(ss.accept());
               j.start();
            }
         }
            catch (IOException e) {
               System.err.println("Server aborted prematurely");
            }
      
      }
   
      public void run() {
      
         String method;
         String ct;
         String version = "";
         File theFile;
         long timestamp = System.currentTimeMillis();
         Date now=new Date();
      
         try {
            PrintStream os = new PrintStream(theConnection.getOutputStream());
            DataInputStream is = new DataInputStream(theConnection.getInputStream());
         
            String get = is.readLine();
            String agent = null;
            StringBuffer sout = new StringBuffer();
         
         // Date has format:   Day Mmm dd hh:mm:ss yyyy
            StringTokenizer dt = new StringTokenizer( (new Date()).toString() );
            String[] da = new String[6];
            int i=0;
            while (dt.hasMoreElements())
            { da[i] = (String) dt.nextElement(); i++; }
         
            sout.append(theConnection.getInetAddress());
            sout.append(" - - [");
            sout.append(da[2]);
            sout.append("/");
            sout.append(da[1]);
            sout.append("/");
            sout.append(da[4]);
            sout.append(":");
            sout.append(da[3]);
            sout.append("] \"");
            sout.append(get.trim());
            sout.append("\" ");
            StringTokenizer st = new StringTokenizer(get);
            method = st.nextToken();
            if (method.equals("GET")) {
               String file = st.nextToken();
               if (file.endsWith("/")) file += indexfile;
               ct = guessContentTypeFromName(file);
               if (st.hasMoreTokens()) {
                  version = st.nextToken();
               }
            // loop through the rest of the input lines 
            
               while ((get = is.readLine()) != null) {
                  get = get.trim();
                  if (get.toUpperCase().startsWith("USER-AGENT: "))
                  { agent=get.substring(12); } 
                  if (get.equals("")) 
                     break;        
               }
            
               try {
                  theFile = new File(docroot, file.substring(1,file.length()));
                  FileInputStream fis = new FileInputStream(theFile);
                  byte[] theData = new byte[(int) theFile.length()];
               // need to check the number of bytes read here
                  fis.read(theData);
                  fis.close();
               
                  if (version.startsWith("HTTP/")) {  // send a MIME header
                     os.print("HTTP/1.0 200 OK\r\n");
                     os.print("Date: " + now + "\r\n");
                     os.print("Server: jhttp 1.0\r\n");
                     os.print("Content-length: " + theData.length + "\r\n");
                     os.print("Content-type: " + ct + "\r\n\r\n");
                  }  // end try
               
               // send the file
                  os.write(theData);
                  os.close();
                  sout.append("200 ");
                  sout.append(theData.length);
               }  // end try
                  catch (IOException e) {  // can't find the file
                     if (version.startsWith("HTTP/")) {  // send a MIME header
                        os.print("HTTP/1.0 404 File Not Found\r\n");
                        os.print("Date: " + now + "\r\n");
                        os.print("Server: jhttp 1.0\r\n");
                        os.print("Content-type: text/html" + "\r\n\r\n");
                     } 
                     os.println("<HTML><HEAD><TITLE>File Not Found</TITLE></HEAD>");
                     os.println("<BODY><H1>HTTP Error 404: File Not Found</H1></BODY></HTML>");
                     os.close();
                     sout.append("404 File Not Found");
                  }
            }
            else {  // method does not equal "GET"
               if (version.startsWith("HTTP/")) {  // send a MIME header
                  os.print("HTTP/1.0 501 Not Implemented\r\n");
                  os.print("Date: " + now + "\r\n");
                  os.print("Server: jhttp 1.0\r\n");
                  os.print("Content-type: text/html" + "\r\n\r\n"); 
               }       
               os.println("<HTML><HEAD><TITLE>Not Implemented</TITLE></HEAD>");
               os.println("<BODY><H1>HTTP Error 501: Not Implemented</H1></BODY></HTML>");
               os.close();
               sout.append("501 Not Implemented");
            }
            if (agent!=null)
            {
               sout.append(" ");
               sout.append(agent);
            }
            sout.append(" ");
            sout.append( (System.currentTimeMillis()-timestamp) );
            sout.append("mS");
            System.out.println(sout.toString());
         }
            catch (IOException e) {
            
            }
         try {
            theConnection.close();
         }
            catch (IOException e) {
            }
      
      }
   
      public String guessContentTypeFromName(String nam) {
         String name = nam.toLowerCase();
      
         if (name.endsWith(".html") || name.endsWith(".htm")
            || name.endsWith(".shtml")) 
            return "text/html";
         else if (name.endsWith(".txt") || name.endsWith(".java")) 
            return "text/plain";
         else if (name.endsWith(".gif") ) 
            return "image/gif";
         else if (name.endsWith(".class") ) 
            return "application/octet-stream";
         else if (name.endsWith(".jpg") || name.endsWith(".jpeg")) 
            return "image/jpeg";
         else if (name.endsWith(".pdf")) 
            return "application/pdf";
         else 
            return "text/plain";
      }
   
   }
