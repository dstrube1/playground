//#include <iostream>
#include <fstream.h>
#include <string>

//2004-08-24
//David Strube
//photo_urls

//after placing the photos from the 2004 users conference here:
// \\Wwwserver\jmjprod\attachments\user_conf_2004\photos
//from here:
// \\Dellserv\jmjfiles\photos\user_conference_2004
// need to list the files' urls

//So, from a dir print out comes a file that is the input for this program
//Output = urls

   int main(){
   
   		/***********************
   		start things off, get stuff initialised
   		*************************/
      ifstream infi ("photos.txt");
      ofstream outfi ("out.txt");
      string intemp, jpg1, jpg2, outemp;
   	string url_prefix="http://www.jmjtech.com/attachments/user_conf_2004/photos/";
      jpg1=".jpg";
      jpg2=".JPG";
      int jpg1_L=0;
      int jpg2_L=0;
      int size=0;
      int space_L=0;
      int count=0;
   
   		/***********************
   		now the fun begins
   		*************************/
   
      while (getline(infi, intemp)){
      //cout<<"testing "<<intemp<<endl;
         jpg1_L=intemp.find(jpg1);
         jpg2_L=intemp.find(jpg2);
         size=intemp.size();
         space_L=intemp.rfind(" ");
         if ((jpg1_L!=-1) || (jpg2_L!=-1)) {
            //cout<<".jpg:\n"<<intemp<<endl;
            outemp=intemp.substr(space_L+1, size-space_L);
            outfi<<url_prefix<<outemp<<endl;
            count++;
         }
         //else
            //cout<<"not .jpg:\n"<<intemp<<endl;
      
         //cout<<"intemp.find(jpg) = "<<jpg_L<<endl;
         //getline(infi, intemp);
         jpg1_L=0;
         jpg2_L=0;
         size=0;
         space_L=0;
      
      
      }
      infi.close();
   	//outfi<<"count: "<<count;
      outfi.close();
      return 0;
   }
	/*
	photos.txt data:
	 Volume in drive C has no label.
 Volume Serial Number is 2020-1763

 Directory of C:\david\temp

08/16/2004  12:16 PM    <DIR>          .
08/16/2004  12:16 PM    <DIR>          ..
08/12/2004  10:32 AM         1,003,868 cake_10th.jpg
08/12/2004  10:36 AM           989,303 jim_c.JPG
08/16/2004  12:16 PM                 0 out.txt
01/01/2002  12:00 AM           430,557 P1010041.JPG
01/01/2002  12:00 AM           406,372 P1010042.JPG
01/01/2002  12:00 AM           406,361 P1010043.JPG
01/01/2002  12:00 AM           405,261 P1010044.JPG
01/01/2002  12:00 AM           400,250 P1010045.JPG
01/01/2002  12:00 AM           400,111 P1010046.JPG
01/01/2002  12:00 AM           429,596 P1010047.JPG
01/01/2002  12:00 AM           410,839 P1010048.JPG
01/01/2002  12:00 AM           411,172 P1010049.JPG
01/01/2002  12:00 AM           418,118 P1010053.JPG
01/01/2002  12:00 AM           417,617 P1010054.JPG
01/01/2002  12:00 AM           429,331 P1010055.JPG
01/01/2002  12:00 AM           426,066 P1010056.JPG
01/01/2002  12:00 AM           414,896 P1010057.JPG
01/01/2002  12:00 AM           430,490 P1010058.JPG
01/01/2002  12:00 AM           423,056 P1010059.JPG
01/01/2002  12:00 AM           426,915 P1010060.JPG
01/01/2002  12:00 AM           431,062 P1010061.JPG
01/01/2002  12:00 AM           427,056 P1010062.JPG
01/01/2002  12:00 AM           420,456 P1010063.JPG
01/01/2002  12:00 AM           411,322 P1010064.JPG
01/01/2002  12:00 AM           422,909 P1010065.JPG
01/01/2002  12:00 AM           410,702 P1010066.JPG
01/01/2002  12:00 AM           433,837 P1010067.JPG
01/01/2002  12:00 AM           440,692 P1010068.JPG
01/01/2002  12:00 AM           414,502 P1010069.JPG
01/01/2002  12:00 AM           435,416 P1010070.JPG
01/01/2002  12:00 AM           403,388 P1010071.JPG
01/01/2002  12:00 AM           400,958 P1010072.JPG
01/01/2002  12:00 AM           386,723 P1010073.JPG
08/12/2004  10:34 AM         1,321,298 P1010074.JPG
08/12/2004  10:34 AM           983,121 P1010075.JPG
08/12/2004  10:34 AM         2,052,024 P1010076.JPG
08/12/2004  10:34 AM         1,380,434 P1010077.JPG
08/12/2004  10:34 AM         1,217,431 P1010078.JPG
01/01/2002  12:00 AM           421,805 P1010079.JPG
01/01/2002  12:00 AM           398,518 P1010080.JPG
01/01/2002  12:00 AM           440,059 P1010081.JPG
01/01/2002  12:00 AM           425,929 P1010082.JPG
              42 File(s)     23,159,821 bytes

     Total Files Listed:
              42 File(s)     23,159,821 bytes
               2 Dir(s)   4,613,558,272 bytes free

	*/