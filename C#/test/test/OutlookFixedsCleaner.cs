using System;
using System.Collections.Generic;
using Outlook = Microsoft.Office.Interop.Outlook;

namespace test
{
    class OutlookFixedsCleaner
    {
        //static string[] subjects;
        private static List<String> ticketNums = new List<String>();
        private static List<Outlook.MailItem> mails = new List<Outlook.MailItem>();
        private static string SICS = "(SIBIR-";
        //SICS, SIOPS, SIP, DMSREL, HD, SIPM

        public OutlookFixedsCleaner() { }

        /// <summary>
        /// Go thru all emails in the fixed folder.
        /// If email is the best one, keep it; else move it to a to-be-deleteds folder
        /// </summary>
        public void doStuff() {
            //_Folders folders;

            //Outlook.NavigationFolder f1;
            //Outlook.Folder f2;
            Outlook.Application app = new Outlook.Application();
            Outlook.NameSpace oNS = app.GetNamespace("MAPI");

            //Console.WriteLine("Hit Enter to select the input folder.");
            //Console.ReadLine();
            //Outlook.MAPIFolder folder = oNS.PickFolder();
            Outlook.MAPIFolder inbox = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox); //.Parent;
            Outlook.MAPIFolder folder = setFolder(inbox, @"\\David.Strube@IgnitionOne.com\Inbox\issues\fixed");
            if (folder == null)
            {
                Console.WriteLine("Error: folder is null.");
                Console.ReadLine();
                return;
            }

            //Console.WriteLine("Hit Enter to select the temp resolved folder.");
            //Console.ReadLine();
            //Outlook.MAPIFolder tempRFolder = oNS.PickFolder();
            Outlook.MAPIFolder tempRFolder = setFolder(inbox, @"\\David.Strube@IgnitionOne.com\Inbox\issues\fixed\tempResolved");
            if (tempRFolder == null)
            {
                Console.WriteLine("Error: tempRFolder is null.");
                Console.ReadLine();
                return;
            }

            //Console.WriteLine("Hit Enter to select the temp unresolved folder.");
            //Console.ReadLine();
            //Outlook.MAPIFolder tempUFolder = oNS.PickFolder();
            //Outlook.MAPIFolder tempUFolder = setFolder(inbox, @"\\David.Strube@IgnitionOne.com\Inbox\issues\fixed\tempUnresolved");
            //if (tempUFolder == null)
            //{
            //    Console.WriteLine("Error: tempUFolder is null.");
            //    Console.ReadLine();
            //    return;
            //}
            Outlook.MAPIFolder tempDFolder = setFolder(inbox, @"\\David.Strube@IgnitionOne.com\Inbox\issues\fixed\tempDelete");
            if (tempDFolder == null)
            {
                Console.WriteLine("Error: tempDFolder is null.");
                Console.ReadLine();
                return;
            }

            //Console.WriteLine("folder path: " + folder.FolderPath); //not easily settable :(
            //Console.WriteLine("folder path Parent: " + folder.Parent.FolderPath);
            //listFolders(folder);
            //listItemStats(folder);

            if (folder.Items.Count <= 0)
            {
                Console.WriteLine("Error: No items in folder.");
                Console.ReadLine();
                return;
            }

            //Console.WriteLine("Hit Enter to move stuff around."); //move one message from the input folder to the temp folder.");
            //Console.ReadLine();
            Console.WriteLine("Setting stuff up.");

            //1- get all distinct ticket numbers
            foreach (Outlook.MailItem mail in folder.Items)
            //for (int i=1; i< folder.Items.Count; i++)
            {
                //Outlook.MailItem mail = folder.Items[i];
                //Console.WriteLine("i=" + i + "; subject=" + mail.Subject);

                //learned the hard way that moving mail from folder changes folder Items count, which breaks even foreach
                //must copy it all into some other container before moving anything
                if (!mail.Subject.Contains(SICS)) { continue; }
                mails.Add(mail);

                int indexOfSICS = mail.Subject.IndexOf(SICS);

                string ticketNum = mail.Subject.Substring(indexOfSICS, mail.Subject.IndexOf(")", indexOfSICS) - indexOfSICS + 1);

                if (!ticketNums.Contains(ticketNum))
                {
                    Console.Write(".");
                    ticketNums.Add(ticketNum);
                }
                //break;
                //Console.WriteLine("ticketNum = " + ticketNum + "; date = " + mailDate);
            }
            Console.WriteLine("\nCount of distinct ticket nums:" + ticketNums.Count);
            Console.WriteLine("Moving stuff around");

            //2- for each ticket number, 
            /*if this is the resolved ticket email
             *      move it to a resolved folder; 
             * else if there is a resolved for it, 
             *      move this to delete
             * else, if is this the newest of this ticket number
             *      move it to a resolved folder; 
             * else
             *      move this to delete
             */
            foreach (string ticketNum in ticketNums)
            {
                foreach (Outlook.MailItem mail in mails)
                {
                    if (!mail.Subject.Contains(SICS)) { continue; }

                    int indexOfSICS = mail.Subject.IndexOf(SICS);

                    string ticketNumTemp = mail.Subject.Substring(indexOfSICS, mail.Subject.IndexOf(")", indexOfSICS) - indexOfSICS + 1);
                    if (ticketNumTemp != ticketNum) { continue; }

                    if (mail.Subject.Contains("Resolved"))
                    {
                        mail.Move(tempRFolder);
                    }
                    else if (isAResolved(ticketNum))
                    {
                        mail.Move(tempDFolder);
                    }
                    else if (isNewest(mail))
                    {
                        mail.Move(tempRFolder);
                    }
                    else
                    {
                        mail.Move(tempDFolder);
                    }
                }
                Console.Write(".");
            }


            //Console.WriteLine("All ticketNums in ticketNums: ");
            //foreach (string ticketNum in ticketNums)
            //{
            //    Console.WriteLine("ticketNum: " + ticketNum);
            //}

            Console.WriteLine("\nDone. Hit Enter to exit.");
            Console.ReadLine();
        }

        private static bool isNewest(Outlook.MailItem mailToCheck)
        {
            bool newestSoFar = true;
            int indexOfSICS = mailToCheck.Subject.IndexOf(SICS);
            string ticketNum = mailToCheck.Subject.Substring(indexOfSICS, mailToCheck.Subject.IndexOf(")", indexOfSICS) - indexOfSICS + 1);

            foreach (Outlook.MailItem mail in mails)
            {
                indexOfSICS = mail.Subject.IndexOf(SICS);
                if (indexOfSICS == -1) { continue; }

                string ticketNumTemp = mail.Subject.Substring(indexOfSICS, mail.Subject.IndexOf(")", indexOfSICS) - indexOfSICS + 1);
                if (ticketNumTemp != ticketNum) { continue; }
                if (mailToCheck.ReceivedTime < mail.ReceivedTime)
                {
                    newestSoFar = false;
                }
            }
            return newestSoFar;
        }

        private static bool isAResolved(string ticketNum)
        {
            foreach (Outlook.MailItem mail in mails)
            {
                int indexOfSICS = mail.Subject.IndexOf(SICS);
                if (indexOfSICS == -1) { continue; }

                string ticketNumTemp = mail.Subject.Substring(indexOfSICS, mail.Subject.IndexOf(")", indexOfSICS) - indexOfSICS + 1);
                if (ticketNumTemp != ticketNum) { continue; }
                if (mail.Subject.Contains("Resolved"))
                {
                    return true;
                }
            }
            return false;
        }

        private static void listItemStats(Outlook.MAPIFolder folder)
        {
            foreach (Outlook.MailItem mail in folder.Items)
            {
                //Console.WriteLine("mail subject = " + mail.Subject);
            }
            Console.WriteLine("folder.ShowItemCount: " + folder.ShowItemCount.ToString());
            Console.WriteLine("folder.Items.Count: " + folder.Items.Count);
            Console.WriteLine("folder.DefaultMessageClass: " + folder.DefaultMessageClass);
            //
        }
        private static void listFolders(Outlook.MAPIFolder folder)
        {
            foreach (Outlook.MAPIFolder f1 in folder.Folders)
            {
                Console.WriteLine("folder path: " + f1.FolderPath);
                if (f1.Folders.Count > 0)
                {
                    listFolders(f1);
                }
            }
        }
        private static Outlook.MAPIFolder setFolder(Outlook.MAPIFolder folder, string folderPath)
        {
            foreach (Outlook.MAPIFolder f1 in folder.Folders)
            {
                //Console.WriteLine("folder path: " + f1.FolderPath);
                if (f1.FolderPath == folderPath)
                {
                    return f1;
                }
                else if (f1.Folders.Count > 0)
                {
                    return setFolder(f1, folderPath);
                }
            }
            return null;
        }


    }
}
