using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;

//get address info here:
//http://www.legis.state.ga.us/legis/2005_06/house/bios/<dirname>/<dirname>.htm
//dir names will be like: Last,%20First
//get congress.org id from here:
//http://www.congress.org/congressorg/officials/membersearch/?state=GA&lvl=state&x=1600&y=900&searchlast=<lastname>+&x=0&y=0
/*
Purpose: get data from the directory in BaseAddress to find represenative homepages to 
 * know who to look for on congress.org (and get their congress.orgID)
 * & find representative data

 */

namespace RepInfoCrawl
{
    class Program
    {
        #region globals
        //public WebClient client = new WebClient();
        private const string BaseAddress = "http://www.legis.state.ga.us/legis/2005_06/house/bios/";
        //private const string BaseAddress = "";
        //http://www.dotnetcoders.com/web/Learning/Regex/exHrefExtractor.aspx
        private const string URLpattern = "href\\s*=\\s*(?:(?:\\\"(?<url>[^\\\"]*)\\\")|(?<url>[^\\s]* ))";
        private Regex URLregex = new Regex(URLpattern);
        private string folder = null; //rep dir
        private string file = null; //rep page name
        private string district = null;
        private const bool debug = false;
        #endregion //globals

        public static void Main(string[] args)
        {
            //let's get this party started
            Console.WriteLine("District\tName\tCongressID\tParty\tPhone\tAddress");
            Program anInstanceofMyClass = new Program();
            try
            {
                anInstanceofMyClass.doMainSearch();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
            if (debug)
            {
                Console.WriteLine("\ndone");
                Console.ReadLine();
            }
        }
        private void doStuff()
        {
/*
            //byte[] myDataBuffer = client.DownloadData(client.BaseAddress);
            // Display the downloaded data.
            //string download = Encoding.ASCII.GetString(myDataBuffer);
            //Console.WriteLine(download);
            //Console.ReadLine();

            //StreamReader srMainDir = new StreamReader(client.OpenRead(client.BaseAddress));
            //StreamReader srMainDir = new StreamReader(responseMainDir.GetResponseStream());
            while (sr3.Peek() != -1)
            { //in the rep's homepage
                count++;
                Console.WriteLine("Reading line " + count);
                line = sr3.ReadLine();
                if (line.Contains("District "))
                {
                    Match m_district = Districtregex.Match(line);
                    if (m_district.Success)
                    {
                        Console.WriteLine(folder + " = district " +
                            m_district.Groups["number"].Value);
                        continue;
                    }
                    else Console.WriteLine(line + " != " + DistrictPattern);
                }
            }// end rep's homepage while
 */
        }
        private void doMainSearch()
        {
            bool goAhead = false;
            string lines = null;
            HttpWebRequest request;
            HttpWebResponse response;
            request = (HttpWebRequest)WebRequest.Create(BaseAddress);
            response = (HttpWebResponse)request.GetResponse();
            lines = new StreamReader(response.GetResponseStream()).ReadToEnd();
            MatchCollection mc = URLregex.Matches(lines);
            foreach (Match m in mc) { 
                //should have only one group per match
                if (m.Success && m.Groups["url"].Value.EndsWith("/"))
                    //m.Groups["url"].Value.Contains(",%20"))
                    //might not contain ',%20', but will be a directory
                {
                    if (!m.Groups["url"].Value.Equals("/legis/2005_06/house/"))
                    {
                        folder = m.Groups["url"].Value;
                        if (debug)
                        {
                            if (folder.StartsWith("Bruce"))
                                goAhead = true;
                            if (goAhead)
                            {
                                Console.WriteLine("folder = " + folder);
                                doRepDirSearch();
                                goAhead = false;
                            }
                        }
                        else doRepDirSearch();
                    }
                }
            }
        }

        private void doRepDirSearch()
        {
            string lines = null;
            HttpWebRequest request;
            HttpWebResponse response;
            request = (HttpWebRequest)WebRequest.Create(BaseAddress + folder);
            //Console.WriteLine(BaseAddress + folder);
            response = (HttpWebResponse)request.GetResponse();
            lines = new StreamReader(response.GetResponseStream()).ReadToEnd();
            MatchCollection mc = URLregex.Matches(lines);
            foreach (Match m in mc)
            {
                //should have only one group per match
                if (m.Success && m.Groups["url"].Value.Contains(",%20") &&
                    (m.Groups["url"].Value.EndsWith(".htm") || m.Groups["url"].Value.EndsWith(".html")))
                {
                    file = m.Groups["url"].Value;
                    if (debug)
                    Console.WriteLine("file = "+file);
                    if (folder.Substring(0, folder.Length - 1).Equals(
                        file.Substring(0, file.IndexOf(".")/*file.Length - 4*/), StringComparison.CurrentCultureIgnoreCase))
                    {
                        doRepPageSearch();
                    }
                    //removing this break because below assumption proved wrong - example Judy Manning
                    //break;//putting this outside the fiile == folder check because 
                    //the right htm file, if it exists, will come first
                }
            }
        }

        private void doRepPageSearch()
        {
            //expected data output format:
            //district # \t name \t congressID \t party \t [phone] \t [address]
            HttpWebRequest request;
            HttpWebResponse response;
            request = (HttpWebRequest)WebRequest.Create(BaseAddress + folder + file);
            response = (HttpWebResponse)request.GetResponse();
            string lines = new StreamReader(response.GetResponseStream()).ReadToEnd();

            doRepDistrictSearch(lines);
            Console.Write('\t');
            doCongressOrgSearch();
            Console.Write('\t');
            doRepPhoneSearch(lines);
            Console.Write('\t');
            doRepAddressSearch(lines);
            Console.WriteLine();
        }
        private void doRepDistrictSearch(string lines)
        {
            const string DistrictPattern = "District (?<district>\\d+)";
            Regex Districtregex = new Regex(DistrictPattern);
            MatchCollection mDistrict = Districtregex.Matches(lines);
            foreach (Match m in mDistrict)
            {
                if (m.Success)
                {
                    district = m.Groups["district"].Value;
                    Console.Write(district + '\t' + folder);
                    break;
                }
            }
        }
        
        private void doCongressOrgSearch()
        {
            string lines = null;
            const string CongressOrg1 = "http://www.congress.org/congressorg/officials/membersearch/?state=GA&lvl=state&searchlast=";
            const string CongressOrg2 = "&x=0&y=0";
            HttpWebRequest request;
            HttpWebResponse response;
            string CongressPattern = ".*id=(?<id>\\d+).*\\((?<party>D|R|I)-GA " + district + "(st|nd|rd|th)\\).*";
            Regex Congressregex = new Regex(CongressPattern);
            request = (HttpWebRequest)WebRequest.Create(CongressOrg1 + folder.Substring(0, folder.IndexOf(","))
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

        private void doRepAddressSearch(string lines)
        {
            string data = null;
            const string AddressPattern = "at the Capitol(.*\n){8}";
            Regex Addressregex = new Regex(AddressPattern);
            MatchCollection mAddresses = Addressregex.Matches(lines);
            foreach (Match m in mAddresses)
            {
                if (m.Success)
                {
                    data = m.Groups[0].Value;
                    data = data.Substring(data.IndexOf("style2") + 1);
                    data = data.Substring(data.IndexOf("style2") + 8);
                    data = data.Replace("<br>", "");
                    if (data.Contains("<!--"))
                        data = data.Remove(data.IndexOf("<!--"), data.IndexOf("-->"));
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
                    Console.Write(data);
                    break;
                }
            }
        }
        
    }
}
