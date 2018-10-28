// InputEventDemo.h : main header file for the INPUTEVENTDEMO application
//

#if !defined(AFX_INPUTEVENTDEMO_H__2E6F44CD_5A63_48AC_8C68_D5EDFE06FA7E__INCLUDED_)
#define AFX_INPUTEVENTDEMO_H__2E6F44CD_5A63_48AC_8C68_D5EDFE06FA7E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CInputEventDemoApp:
// See InputEventDemo.cpp for the implementation of this class
//

class CInputEventDemoApp : public CWinApp
{
public:
	CInputEventDemoApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInputEventDemoApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CInputEventDemoApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INPUTEVENTDEMO_H__2E6F44CD_5A63_48AC_8C68_D5EDFE06FA7E__INCLUDED_)
