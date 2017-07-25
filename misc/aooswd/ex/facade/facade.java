public class Compiler
{
	public Compiler ();
	public void Compile (InputStream, ByteCodeStream)
	{
		Scanner scanner = new Scanner (InputStream);
		ProgramNodeBuilder builder = new ProgramNodeBuilder ();
		Parser parser = new parser ();
		parser.Parse (scanner, builder);
		RISCCodeGenerator generator = new generator (output);
		ProgramNode parseTree = builder. GetRootNode ();
		parseTree. Traverse (generator);
	}
}

could change to take components as arguments if components could vary