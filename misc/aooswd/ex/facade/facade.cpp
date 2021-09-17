class Compiler
{
	Compiler ();
	virtual void Compile (istream&, ByteCodeStream&);
};

void Compiler::Compile (istream& input, ByteCodeStream& output)
{
	Scanner scanner (input);
	ProgramNodeBuilder builder;
	Parser parser;
	parser. Parse (scanner, builder);
	RISCCodeGenerator generator (output);
	ProgramNode* parseTree = builder. GetRootNode ();
	parseTree -> Traverse (generator);
}

could change to take components as arguments if components could vary