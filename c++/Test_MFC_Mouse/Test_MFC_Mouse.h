// Test_MFC_Mouse.h : main header file for the Test_MFC_Mouse application
//
#pragma once

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols


// CTest_MFC_MouseApp:
// See Test_MFC_Mouse.cpp for the implementation of this class
//

class CTest_MFC_MouseApp : public CWinApp
{
public:
	CTest_MFC_MouseApp();


// Overrides
public:
	virtual BOOL InitInstance();

// Implementation
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CTest_MFC_MouseApp theApp;