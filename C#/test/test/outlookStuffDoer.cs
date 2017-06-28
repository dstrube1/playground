using System;
using System.Collections.Generic;
using Outlook = Microsoft.Office.Interop.Outlook;
//using Microsoft.Office.Interop.OutlookViewCtl;

namespace test
{
    public class outlookStuffDoer
    {
        //private static List<String> subjects = new List<String>();
        //private static List<Outlook.MailItem> mails = new List<Outlook.MailItem>();

        private static void doStuff(string[] args)
        {
            //testing outlook folder navigation

            //_Folders folders;

            Outlook.NavigationFolder f1;
            Outlook.Folder f2;
            Outlook.Application app = new Outlook.Application();
            Outlook.NameSpace oNS = app.GetNamespace("MAPI");

            Console.WriteLine("Hit Enter to select the input folder.");
            Console.ReadLine();
            Outlook.MAPIFolder folder = oNS.PickFolder();
            Outlook.MAPIFolder inbox = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox); //.Parent;

            listFolders(inbox);

        }

        private static void listFolders(Outlook.MAPIFolder folder)
        {
            foreach (Outlook.MAPIFolder f1 in folder.Folders)
            {
                Console.WriteLine("folder path: " + f1.FolderPath);
                if (f1.Items.Count > 0)
                {
                    showBiggestEmail(f1);
                }
                if (f1.Folders.Count > 0)
                {
                    listFolders(f1);
                }
            }
        }

        private static void showBiggestEmail(Outlook.MAPIFolder folder)
        {
            Outlook.MailItem biggestMail = null;
            foreach (Object o in folder.Items)
            {
                Outlook.MailItem mail = null;
                if (o is Outlook.MailItem) { mail = o as Outlook.MailItem; } else { continue; }
                if (biggestMail == null) { biggestMail = mail; }
                else if (biggestMail.Size < mail.Size) { biggestMail = mail; }
            }
            Console.WriteLine("biggestMail subject: " + biggestMail.Subject);
            Console.WriteLine("biggestMail size: " + biggestMail.Size);
            return;

        }



    }
}