#include "stdafx.h"
#include "resource.h"
#include "BrowserDlg.hpp"

ATL::CComModule _Module;

// The main drip application.
//
class DripApp: public CWinApp {
public:
	BOOL InitInstance() {
		OleInitialize(NULL);
		AfxEnableControlContainer();

		// Create the main dialog and display it.  The application
		//   will end when this dialog is closed.
		//
		CBrowserDlg* dlg = new CBrowserDlg();
		dlg->Create(CBrowserDlg::IDD);
		dlg->ShowWindow(SW_SHOWNORMAL);
		dlg->SetForegroundWindow();
		m_pMainWnd = dlg;

		return TRUE;
	}

	int ExitInstance() {
		OleUninitialize();
		return 0;
	}
} dripApp;
