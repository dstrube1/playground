using System;
//using System.Collections.Generic;
//using System.Text;
using System.Net.Mail;

namespace test2005
{
    class Program
    {
        static void Main(string[] args)
        {
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("Melanie.Forsberg@jmjtech.com");
            msg.To.Add("d_54321@yahoo.com");
            msg.Subject = "Test";
            msg.Body = "do you hear me?...";
            msg.IsBodyHtml = true;
            SmtpClient s = new SmtpClient(); //assign smtp server here
            s.Host = "mail.jmjtech.com";
            
            try
            {
                //s.Host = "";
                //s.Host.Insert(0, "mail2.jmjtech.com");
                s.Send(msg); //this line actually fires the msg out
            }
            catch (Exception exception1)
            {
                Console.WriteLine("error :" + exception1.ToString());
                Console.ReadLine();
            }
        }
    }
}
