import java.io.File;
import java.io.IOException;

public class Driver {

	public Driver() {
	}

	private static int count = 0;
	
	public static void main(String[] args) {
		String dirname = "C:\\Users\\unbounded\\Google Drive\\Unbounded\\apps\\src";
		searchAndDestroy(dirname);

		System.out.println("Hit enter to exit.");
		try {
			int i = System.in.read();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static void searchAndDestroy(String path) {
		File root = new File(path);
		if (root.isDirectory()) {
			for (File file : root.listFiles()) {
				searchAndDestroy(file.getAbsolutePath());
			}
		} else if (root.isFile()
				&& root.getAbsolutePath().endsWith("desktop.ini")) {
			try {
				if (!root.delete()) {
					System.out.println("Problem: " + root.getCanonicalPath());
				}else{
					System.out.print(".");
					count++;
					if (count > 60){
						count = 0;
						System.out.println();
					}
//					System.out.println("Deleted: " + root.getCanonicalPath());
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
