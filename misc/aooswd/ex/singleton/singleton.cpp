class Singleton
{
public:
  static Singleton* Instance ();
protected:
  Singleton ();
private:
  static Singleton* _instance;
};

Singleton* Singleton::_instance = 0;
Singleton* Singleton::Instance ()
{
  if (_instance == 0)
    _instance = new Singleton;
  return _instance;
}

class Singleton
{
public:
  static void Register (char* name, Singleton*);
  static Singleton* Instance ();
protected:
  static Singleton* Lookup (const char* name);
private:
  static Singleton* _instance;
  static List<NameSingletonPair>* _registry;
};

