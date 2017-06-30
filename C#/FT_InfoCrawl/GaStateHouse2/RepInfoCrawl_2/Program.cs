using System;
using System.Collections;
using System.Text;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;
/*
Purpose: get data from the directory in BaseAddress to find represenative homepages to 
 * find district addresses, phone numbers
*/
namespace RepInfoCrawl_2
{
    class Program
    {
        #region globals
        private const bool debug = false;
        private bool stop = false;
        private const string BaseAddress = "http://fairtaxscorecard.com/Replookup.phtml?LookupBy=office&GLevel=S&StateID=GA&Branch=H&CongLeadID=";
        private ArrayList districtID = new ArrayList();
        private const string URLpattern = "linkicon\\('(?<url>[^\\s]*)','web'\\)\\)";
        private Regex URLregex = new Regex(URLpattern);
        private string lastName = null;
        #endregion //globals

        static void Main(string[] args)
        {
            Console.WriteLine("District\tName\tCongressID\tParty\tPhone\tAddress\t\tHome");
            Program anInstanceofMyClass = new Program();
            try
            {
                anInstanceofMyClass.doMainSearch();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                if (debug) Console.ReadLine();
            }
            if (debug)
            {
                Console.WriteLine("\ndone");
                Console.ReadLine();
            }
        }

        private void doMainSearch()
        {
         //   bool goAhead = false;
            doDistrictIDs();
            string lines = null;
            HttpWebRequest request;
            HttpWebResponse response;
            string lastNamepattern = "\\+2\\\">(?<lastname>.*)\\, .*";
            Regex lastNameregex = new Regex(lastNamepattern);
            //const string Emailpattern = @"linkicon\('.*@.*','mail'\)\)";
            //Regex Emailregex = new Regex(Emailpattern);
            
            for (int i = 0; i < districtID.Count; i++)
            {
            //int i = 138;
                //if (debug)
                    //Console.WriteLine("testing " + districtID[i].ToString());
                request = (HttpWebRequest)WebRequest.Create(BaseAddress + districtID[i].ToString().Substring(0,4));
                response = (HttpWebResponse)request.GetResponse();
                lines = new StreamReader(response.GetResponseStream()).ReadToEnd();

                MatchCollection m_lastName = lastNameregex.Matches(lines);
                foreach (Match n in m_lastName)
                {
                    if (n.Success)
                        lastName = n.Groups["lastname"].Value;
                    else lastName = "";
                    //if (debug)
                    //    Console.WriteLine("lastname = '" + lastName+"'");
                }

                MatchCollection mc = URLregex.Matches(lines);
                
                foreach (Match m in mc)
                {
                    if (m.Success)
                    {
                        doRepPageSearch(m.Groups["url"].Value, i);
                        if (stop) { return; }
                    }
                }
           }//end for
        }

        private void doDistrictIDs()
        {
            string path = Directory.GetCurrentDirectory()+"\\id district.txt";
            string line;
            if (!File.Exists(path)) { }
            StreamReader sr = File.OpenText(path);
            while ((line = sr.ReadLine()) != null)
            {
                districtID.Add(line);
            }
            districtID.TrimToSize();
            sr.Close();
        }

        private void doRepPageSearch(string url, int i)
        {
            //expected data output format:
            //district # \t name \t congressID \t party \t [phone] \t [address] \t [home]
            HttpWebRequest request;
            HttpWebResponse response;
            request = (HttpWebRequest)WebRequest.Create(url);
            response = (HttpWebResponse)request.GetResponse();
            string lines = new StreamReader(response.GetResponseStream()).ReadToEnd();
            //if (debug && districtID[i].ToString().Substring(7).Contains("19"))
            //{
            //    stop = true;
                Console.Write(districtID[i].ToString().Substring(7));
                Console.Write('\t');
                Console.Write(lastName);
                Console.Write('\t');
                doCongressOrgSearch(i);
                Console.Write('\t');
                doRepPhoneSearch(lines);
                Console.Write('\t');
                doRepAddressSearch(lines);
                Console.Write('\t');
                doRepHomeSearch(lines);
                Console.WriteLine();
            //}
            
        }

        private void doCongressOrgSearch(int i)
        {
            string lines = null;
            const string CongressOrg1 = "http://www.congress.org/congressorg/officials/membersearch/?state=GA&lvl=state&searchlast=";
            const string CongressOrg2 = "&x=0&y=0";
            HttpWebRequest request;
            HttpWebResponse response;
            string CongressPattern = ".*id=(?<id>\\d+).*\\((?<party>D|R|I)-GA " + 
                Int32.Parse(districtID[i].ToString().Substring(7)) + "(st|nd|rd|th)\\).*";
            Regex Congressregex = new Regex(CongressPattern);
            request = (HttpWebRequest)WebRequest.Create(CongressOrg1 + lastName
                + CongressOrg2);
            response = (HttpWebResponse)request.GetResponse();
            lines = new StreamReader(response.GetResponseStream()).ReadToEnd();
            MatchCollection mCongress = Congressregex.Matches(lines);
            foreach (Match m in mCongress)
            {
                if (m.Success)
                {
                    Console.Write(m.Groups["id"].Value + '\t' + m.Groups["party"].Value);
                    break;
                }
            }
        }

        private void doRepPhoneSearch(string lines)
        {
            const string PhonePattern = "404\\.\\d{3}\\.\\d{4}";
            Regex Phoneregex = new Regex(PhonePattern);
            MatchCollection mPhone = Phoneregex.Matches(lines);
            foreach (Match m in mPhone)
            {
                if (m.Success)
                {
                    Console.Write(m.Groups[0].Value);
                    break;
                }
            }
        }
        
        private void doRepAddressSearch(string lines) {
            string begin = "<!-- InstanceBeginEditable name=\"Address\" -->";
            if (!lines.Contains(begin)) { doRepAddressSearch2(lines); }
            else
            {
                string data = null;
                int start = lines.IndexOf(begin) + begin.Length;
                data = lines.Substring(start, lines.IndexOf("Atlanta")-start);
                data = data.Replace("<br>", "");
                data = data.Replace("              ", "");
                data = data.Replace("-->", "");
                data = data.Replace("Coverdell\nLegislative", "Coverdell Legislative");
                data = data.Trim();
                data = data.Replace('\n', '\t');
                if (data.Contains("Room"))
                    {
                        if (data[data.IndexOf("Room ") + 9] == 'L' ||
                            data[data.IndexOf("Room ") + 9] == 'S')
                        {
                            //Console.WriteLine(data + " has Leg or State after it");
                            data = data.Insert(data.IndexOf("Room ") + 9, "\t");
                        }
                        //else Console.WriteLine()
                    }
                Console.WriteLine(data);
            }
        }

        private void doRepAddressSearch2(string lines)
        {
            string data = null;
            //const string AddressPattern = "InstanceBeginEditable\\sname\\=\\\"Address\\\"(?<meat>.*\n){8}";
            const string AddressPattern = "at the Capitol(.*\n){8}";
            Regex Addressregex = new Regex(AddressPattern);
            MatchCollection mAddresses = Addressregex.Matches(lines);
            foreach (Match m in mAddresses)
            {
                if (m.Success)
                {
                    data = m.Groups[0].Value;
                    //if (debug) { Console.WriteLine("\n"+data); }
                    data = data.Replace("<br>", "");
                    if (data.Contains("<!--"))
                    {
                        //if (debug) {
                        //    Console.WriteLine("\ndata.IndexOf(<!--) = "+
                        //        data.IndexOf("<!--") + "; data.IndexOf(-- > ) = " + 
                        //        data.IndexOf("-->"));
                        //}
                        data = data.Remove(data.IndexOf("<!--"),
                            data.IndexOf("-->") - data.IndexOf("<!--"));
                    }
                    data = data.Substring(data.IndexOf("style2") + 1);
                    data = data.Substring(data.IndexOf("style2") + 8);
                    data = data.Replace("              ", "");
                    data = data.Replace("-->", "");
                    data = data.Replace("Coverdell\nLegislative", "Coverdell Legislative");
                    data = data.Trim();
                    data = data.Replace('\n', '\t');
                    //some reps put room on the same line as address line 1; some do not
                    if (data.Contains("Room"))
                    {
                        if (data[data.IndexOf("Room ") + 9] == 'L' ||
                            data[data.IndexOf("Room ") + 9] == 'S')
                        {
                            //Console.WriteLine(data + " has Leg or State after it");
                            data = data.Insert(data.IndexOf("Room ") + 9, "\t");
                        }
                        //else Console.WriteLine()
                    }
                    Console.WriteLine(data);
                    break;
                }
            }
        }

        private void doRepHomeSearch(string lines) {
            string begin = "<!-- InstanceBeginEditable name=\"home\" -->";
            if (!lines.Contains(begin)) { doRepHomeSearch2(lines); }
            else
            {
                string data = null;
                string end = null;
                int start = lines.IndexOf(begin) + begin.Length;
                if (-1 != lines.IndexOf("Occupation", start))
                    end = "Occupation";
                else if (-1 != lines.IndexOf("Birthdate", start))
                    end = "Birthdate";
                else if (-1 != lines.IndexOf("Spouse", start))
                    end = "Spouse";
                else if (-1 != lines.IndexOf("<!-- InstanceEndEditable -->", start))
                    end = "<!-- InstanceEndEditable -->";
                if (end == null) { 
                    Console.Write("insufficient formatting for home address parse"); 
                    return; }
                int finish = lines.IndexOf(end,start);
                //Console.WriteLine("start = " + start + "\nend = " + finish);
                data = lines.Substring(start, finish - start);
                data = data.Replace("<br>", "");
                data = data.Replace("&nbsp;","");
                data = data.Replace("              ", "");
                data = data.Trim();
                data = data.Replace('\n', '\t');
                Console.Write(data);
            }
        }

        private void doRepHomeSearch2(string lines)
        {
            string begin = "Staff:";
            if (!lines.Contains(begin)) { Console.Write("insufficient formatting for home address parse"); }
            else
            {
                string data = null;
                string end = null;
                int start = lines.IndexOf(begin) + begin.Length;
                if (-1 != lines.IndexOf("Occupation", start))
                    end = "Occupation";
                else if (-1 != lines.IndexOf("Birthdate", start))
                    end = "Birthdate";
                else if (-1 != lines.IndexOf("Spouse", start))
                    end = "Spouse";
                if (end == null)
                {
                    Console.Write("insufficient formatting for home address parse");
                    return;
                }
                int finish = lines.IndexOf(end, start);
                data = lines.Substring(start, finish - start);
                data = data.Substring(data.IndexOf("style2") + 8);
                data = data.Replace("<br>", "");
                data = data.Replace("              ", "");
                data = data.Trim();
                data = data.Replace('\n', '\t');
                Console.Write(data);
            }
        }
    }
}
