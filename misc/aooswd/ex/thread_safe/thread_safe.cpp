template <class LOCK>
class File_Cache
{
	public:
		const void* lookup (const string& path) const;
		void insert (const string& path);
	private:
		const void* lookup_i (const string& path) const;
		void insert_i (const string& path);
		mutable LOCK lock_;
};

void* File_Cache::lookup (const string& path) const
{
	Guard<LOCK> guard (lock_);
	return lookup_i (path);
}

void File_Cache::insert (const string& path)
{
	Guard<LOCK> guard (lock_);
	insert_i (path);
}

