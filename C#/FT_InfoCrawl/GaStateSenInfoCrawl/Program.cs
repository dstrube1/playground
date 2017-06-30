using System;
using System.Collections;
using System.Text;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;

namespace GaStateSenInfoCrawl
{
    class Program
    {
        #region globals
        private const bool debug = false;
        private const bool testing = false;
        private bool stop = false;
        private ArrayList districtID = new ArrayList();
        private const string BaseAddress = "http://fairtaxscorecard.com/Replookup.phtml?LookupBy=office&GLevel=S&StateID=GA&Branch=S&CongLeadID=";
        private const string URLpattern = "linkicon\\('(?<url>[^\\s]*)','web'\\)\\)";
        private Regex URLregex = new Regex(URLpattern); 
        private string lastName = null;
        #endregion //globals

        static void Main(string[] args)
        {
            if (testing)
            {
                Console.WriteLine("District\tName\tCongressID\tParty\n" +
                    "\tCapitolAddress\tCapitolPhone\tCapitolFax\n" +
                    "\tHomeAddress\tHomeCityStateZip\tHomePhone");
            }
            else Console.WriteLine("CongLeadID\tCapitolAddress\tHomeCityStateZip\tCapitolPhone\tCapitolFax\n" +
                    "CongLeadID\tDistrictAddress\tDistrictCityStateZip\tDistrictPhone\tDistrictFax");
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
        private void doMainSearch() {
            doDistrictIDs();
            string lines = null;
            HttpWebRequest request;
            HttpWebResponse response;
            string lastNamepattern = "\\+2\\\">(?<lastname>.*)\\, .*";
            Regex lastNameregex = new Regex(lastNamepattern);
            for (int i = 0; i < districtID.Count; i++)
            {
                request = (HttpWebRequest)WebRequest.Create(BaseAddress + districtID[i].ToString().Substring(0, 4));
                response = (HttpWebResponse)request.GetResponse();
                lines = new StreamReader(response.GetResponseStream()).ReadToEnd();

                MatchCollection m_lastName = lastNameregex.Matches(lines);
                foreach (Match n in m_lastName)
                {
                    if (n.Success)
                        lastName = n.Groups["lastname"].Value;
                    else lastName = "";
                }

                MatchCollection mc = URLregex.Matches(lines);
                foreach (Match m in mc)
                {
                    if (m.Success)
                    {
                        doPageSearch(m.Groups["url"].Value, i);
                        if (stop) { return; }
                    }
                }
            }//end for
        }

        private void doDistrictIDs()
        {
            string path = Directory.GetCurrentDirectory() + "\\id district.txt";
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

        private void doPageSearch(string url, int i)
        {
            HttpWebRequest request;
            HttpWebResponse response;
            request = (HttpWebRequest)WebRequest.Create(url);
            response = (HttpWebResponse)request.GetResponse();
            string lines = new StreamReader(response.GetResponseStream()).ReadToEnd();
            //if (debug && districtID[i].ToString().Substring(7).Contains("19"))
            //{
            //    stop = true;
            if (testing)
            {
                //"District\tName\tCongressID\tParty\n"+
                //    "\tCapitolAddress\tCapitolPhone\tCapitolFax\n"+
                //    "\tHomeAddress\tHomeCityStateZip\tHomePhone"
                Console.Write(districtID[i].ToString().Substring(5));
                Console.Write('\t');
                Console.Write(lastName);
                Console.Write('\t');
                doCongressOrgSearch(i);
                Console.Write("\n\t");
                doAddressSearch(lines);
                Console.Write('\t');
                doPhoneSearch(lines);
                Console.Write('\t');
                doFaxSearch(lines);
                Console.Write("\n\t");
                doHomeSearch(lines);
                Console.Write('\t');
                doHomePhoneSearch(lines);
                Console.WriteLine();
            }
            else {
      //"CongLeadID\tCapitolAddress\tHomeCityStateZip\tCapitolPhone\tCapitolFax\n" +
      //"CongLeadID\tDistrictAddress\tDistrictCityStateZip\tDistrictPhone\tDistrictFax"
                Console.Write(districtID[i].ToString().Substring(0, 4));
                Console.Write("\t");
                doAddressSearch(lines);
                Console.Write('\t');
                doPhoneSearch(lines);
                Console.Write('\t');
                doFaxSearch(lines);
                Console.Write("\n");
                Console.Write(districtID[i].ToString().Substring(0, 4));
                Console.Write('\t'); 
                doHomeSearch(lines);
                Console.Write('\t');
                doHomePhoneSearch(lines);
                Console.WriteLine();
            }
            //}
        }

        private void doCongressOrgSearch(int i)
        {
            string lines = null;
            const string CongressOrg1 = "http://www.congress.org/congressorg/officials/membersearch/?state=GA&lvl=state&searchlast=";
            const string CongressOrg2 = "&x=0&y=0";
            HttpWebRequest request;
            HttpWebResponse response;

            //right here is the main difference from RepInfoCrawl in this method
            //because the districts are not nnn, but Snnn
            string CongressPattern = ".*id=(?<id>\\d+).*\\((?<party>D|R|I)-GA " +
                Int32.Parse(districtID[i].ToString().Substring(6)) + "(st|nd|rd|th)\\).*";
            
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

        private void doPhoneSearch(string lines)
        {
            int begin = 0;
            string data = null;
            if (lines.IndexOf("Capitol Phone:") != -1)
            {
                begin = lines.IndexOf("Capitol Phone");
                begin = lines.IndexOf("Det\">", begin)+5;
                while (lines[begin] == ' ') { begin++; }
                data = lines.Substring(begin, 14);
                if (data[0] != '<')
                    Console.Write(data);
            }
            else if (debug) { Console.Write("Phone not found"); }
        }

        private void doFaxSearch(string lines)
        {
            int begin = 0;
            if (lines.IndexOf("Fax Phone:") != -1)
            {
                begin = lines.IndexOf("Fax Phone:");
                begin = lines.IndexOf("Det\">", begin) + 5;
                Console.Write(lines.Substring(begin, 14));
            }
            else if (debug) { Console.Write("Fax not found"); }
        }

        private void doAddressSearch(string lines)
        {
            int begin = 0;
            int end = 0;
            string data = null;
            if (lines.IndexOf("Capitol Address:") != -1)
            {
                begin = lines.IndexOf("Capitol Address:");
                begin = lines.IndexOf("Det\">", begin) + 5;
                end = lines.IndexOf(" </TD>",begin,StringComparison.CurrentCultureIgnoreCase);
                data = lines.Substring(begin, end - begin);
                if (testing)
                    data = data.Replace("Atlanta GA 30334", "");
                else
                    data = data.Replace("Atlanta GA 30334", "\tAtlanta GA 30334");
                Console.Write(data);
            }
            else if (debug) { Console.Write("Address not found"); }
        }

        private void doHomeSearch(string lines)
        {
            int begin = 0;
            int end = 0;
            string data = null;
            string half1, half2 = null;
            if (lines.IndexOf("District Address:") != -1)
            {
                begin = lines.IndexOf("District Address:");
                begin = lines.IndexOf("Det\">", begin) + 5;
                while (lines[begin] == ' ') begin++;
                end = lines.IndexOf(" </TD>", begin, StringComparison.CurrentCultureIgnoreCase);
                data = lines.Substring(begin, end - begin);
                data = data.Replace(" GA", ", GA");
                if (data.IndexOf("  ") < data.Length / 2) { 
                    //replace the "  " in the first half of the string 
                    //(and not the 2nd half)
                    //with " "
                    begin = data.IndexOf("  ");
                    half1 = data.Substring(0, begin);
                    half2 = data.Substring(begin + 1);
                    data = half1 + half2;
                }
                data = data.Replace("  ", "\t");
                Console.Write(data);
            }
            else if (debug) { Console.Write("District Address not found"); }
        }
        private void doHomePhoneSearch(string lines)
        {
            int begin = 0;
            string data = null;
            if (lines.IndexOf("District Phone:") != -1)
            {
                begin = lines.IndexOf("District Phone:");
                begin = lines.IndexOf("Det\">", begin) + 5;
                while (lines[begin] == ' ') { begin++; }
                data = lines.Substring(begin, 14);

                if (data[0] != '<')
                    Console.Write(data);
            }
            else if (debug) { Console.Write("District phone not found"); }
        }
        
    }
}
