import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

public class Main {

	public static void main(String[] args) {
		short i=Short.MIN_VALUE;
		final String URL1 = "http://liquidtelevision.com/";
		final String URL2 = "http://google.com/";
		Date d  = new Date();
		System.out.println("Started testing at "+d.toString());
		boolean successful = false;
		Date successfulDate = null;
		while (i < Short.MAX_VALUE) {
			d = new Date();
			if (ping(URL1, 2000)) {
				System.out.println("i="+i+"; ping worked at "+d.toString());
				successful = true;
				successfulDate = d;
			}else{
				if (i%100 == 0){
				System.out.println("i="+i+"; ping failed at "+d.toString());
				if (successful){
					System.out.println("*******************************************");
					System.out.println("Last successful was "+successfulDate.toString());
					System.out.println("*******************************************");
				}
				}
			}
			i++;
		}
	}

	// from
	// http://stackoverflow.com/questions/3584210/preferred-java-way-to-ping-a-http-url-for-availability/3584332#3584332
	private static boolean ping(String url, int timeout) {
		url = url.replaceFirst("https", "http"); // Otherwise an exception may
													// be thrown on invalid SSL
													// certificates.

		try {
			HttpURLConnection connection = (HttpURLConnection) new URL(url)
					.openConnection();
			connection.setConnectTimeout(timeout);
			connection.setReadTimeout(timeout);
			connection.setRequestMethod("HEAD");
			int responseCode = connection.getResponseCode();
			return (200 <= responseCode && responseCode <= 399);
		} catch (IOException exception) {
			return false;
		}
	}

	private static void fileNavTest() {
		File[] files = File.listRoots();
		for (File file : files) {
			System.out.println("root:" + file.getAbsolutePath()
					+ "\t useable space: " + formatLong(file.getUsableSpace()));
		}
	}

	private static String formatLong(long L) {
		String temp = "" + L;
		if (temp.length() < 4) {
			return temp;
		}
		StringBuilder sb = new StringBuilder(temp);
		for (int i = temp.length() - 3; i > 0; i -= 3) {
			sb.insert(i, ",");
		}
		temp = sb.toString();
		return temp;
	}
}
