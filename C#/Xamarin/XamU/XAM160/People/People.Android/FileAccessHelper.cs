using System;
using System.IO;

namespace People.Droid
{
    public static class FileAccessHelper
    {
        public static string GetLocalFilePath(string filename)
        {
            return Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Personal), filename);
        }
    }
}
