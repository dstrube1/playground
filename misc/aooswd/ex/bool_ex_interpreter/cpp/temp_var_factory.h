#ifndef _TEMP_VAR_FACTORY_H
#define _TEMP_VAR_FACTORY_H

class TempVarFactory
{
 public:
  TempVarFactory ();
  ~TempVarFactory();
  string getTemp();
 private:
  int num;
};

inline TempVarFactory::TempVarFactory (): num (0)
{
}

inline TempVarFactory::~TempVarFactory()
{
}

inline string TempVarFactory::getTemp()
{
  num++;
  return string("temp") + char(int('0') + num);
}

#endif
