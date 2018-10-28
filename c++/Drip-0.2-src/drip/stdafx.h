#pragma once

#define WIN32_LEAN_AND_MEAN		// Exclude rarely-used stuff from Windows headers

#include <afxwin.h>
#include <afxext.h>
#include <afxhtml.h>
#include <afxcmn.h>

#include <mshtmhst.h>
#include <exdisp.h>
#include <dispex.h>
#include <psapi.h>

#pragma comment(lib, "atl.lib")
#include <atldef.h>
#include <atliface.h>
#include <atlbase.h>
#include <atlcom.h>
#include <atlwin.h>
#include <atltypes.h>

#pragma warning(disable: 4049)      // compiler line number limit
#pragma warning(disable: 4192)
#pragma warning(disable: 4146)
#pragma warning(disable: 4278)
#import <mshtml.tlb> named_guids
#import <msxml3.dll> named_guids
#pragma warning(default: 4192)
#pragma warning(default: 4146) 
#pragma warning(default: 4278)

#include <mshtmdid.h>

// STL
#include <string>
#include <vector>
#include <set>
#include <map>
