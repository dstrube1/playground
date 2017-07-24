#include "stdafx.h"
#include "resource.h"
#include "BrowserDlg.hpp"
#include "LeakDlg.hpp"
#include "JSHook.hpp"
#include <exdisp.h>
#include ".\browserdlg.hpp"

BEGIN_MESSAGE_MAP(CBrowserDlg, CDialog)
	//{{AFX_MSG_MAP(CBrowserDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_SIZE()
	ON_WM_CLOSE()
	ON_WM_DESTROY()
	ON_WM_TIMER()
	ON_BN_CLICKED(IDOK, doNothing)
	ON_BN_CLICKED(IDCANCEL, doNothing)
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_GO, OnBnClickedGo)
	ON_BN_CLICKED(IDC_BACK, OnBnClickedBack)
	ON_BN_CLICKED(IDC_FORWARD, OnBnClickedForward)
	ON_BN_CLICKED(IDC_CHECKLEAKS, OnBnClickedCheckLeaks)
	ON_BN_CLICKED(IDC_BLOW, OnBnClickedBlow)
END_MESSAGE_MAP()

BEGIN_EVENTSINK_MAP(CBrowserDlg, CDialog)
	ON_EVENT(CBrowserDlg, IDC_EXPLORER, 259, DocumentCompleteExplorer, VTS_DISPATCH VTS_PVARIANT)
	ON_EVENT(CBrowserDlg, IDC_EXPLORER, 252, NavigateComplete2Explorer, VTS_DISPATCH VTS_PVARIANT)
	ON_EVENT(CBrowserDlg, IDC_EXPLORER, 273, NewWindow3Explorer, VTS_PDISPATCH VTS_PBOOL VTS_UI4 VTS_BSTR VTS_BSTR)
END_EVENTSINK_MAP()

CBrowserDlg::CBrowserDlg(CWnd* pParent)	: CDialog(CBrowserDlg::IDD, pParent),
	m_waitingForDoc(false), m_waitingForBlankDoc(false), m_blowMode(false)
{
	//{{AFX_DATA_INIT(CBrowserDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT

	m_hIcon = AfxGetApp()->LoadIcon(IDI_ICON1);

	// Create the browser hook, which will be shared across all HTML documents.
	//
	CComObject<JSHook>::CreateInstance(&m_hook);
	m_hook->AddRef();
}

CBrowserDlg::~CBrowserDlg() {
	// Release the browser hook.
	//
	m_hook->Release();
}

void CBrowserDlg::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);

	//{{AFX_DATA_MAP(CBrowserDlg)
	DDX_Control(pDX, IDC_EXPLORER, m_explorer);
	//}}AFX_DATA_MAP
}

BOOL CBrowserDlg::OnInitDialog() {
	CDialog::OnInitDialog();

	// Set the application icon.
	//
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	// Disable the leak check button.
	//
	GetDlgItem(IDC_CHECKLEAKS)->EnableWindow(FALSE);

	// Focus the URL edit control.
	//
	GetDlgItem(IDC_EDITURL)->SetFocus();

	// Must return false when focusing a control.
	//
	return FALSE;
}

void CBrowserDlg::OnPaint() {
	if (IsIconic()) {
		CPaintDC dc(this);

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle.
		//
		CRect rect;
		GetClientRect(&rect);
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon.
		//
		dc.DrawIcon(x, y, m_hIcon);
	}
	else {
		CDialog::OnPaint();
	}
}

HCURSOR CBrowserDlg::OnQueryDragIcon() {
	return (HCURSOR) m_hIcon;
}

void CBrowserDlg::OnSize(UINT nType, int cx, int cy) {
	// FUGLY!  I'm just too lazy to generalize this layout code for now.
	//
	int x = 0;
	int backPos = x += 8;
	int forwardPos = x += 26;
	int editUrlPos = x += 26;
	int editUrlSize = cx - 314;
	int goPos = x += editUrlSize + 2;
	int checkLeaksPos = x += 34;
	int blowPos = x += 82;

	RedrawWindow();
	GetDlgItem(IDC_BLOW)->MoveWindow(blowPos, 8, 128, 20, TRUE);
	GetDlgItem(IDC_CHECKLEAKS)->MoveWindow(checkLeaksPos, 8, 80, 20, TRUE);
	GetDlgItem(IDC_GO)->MoveWindow(goPos, 8, 32, 20, TRUE);

	GetDlgItem(IDC_EDITURL)->MoveWindow(editUrlPos, 8, editUrlSize, 20, TRUE);

	GetDlgItem(IDC_FORWARD)->MoveWindow(forwardPos, 8, 24, 20, TRUE);
	GetDlgItem(IDC_BACK)->MoveWindow(backPos, 8, 24, 20, TRUE);

	GetDlgItem(IDC_MEMLABEL)->MoveWindow(x, 34, 128, 20, TRUE);
	GetDlgItem(IDC_MEMLIST)->MoveWindow(x, 52, 128, cy - 62, TRUE);
	GetDlgItem(IDC_EXPLORER)->MoveWindow(8, 34, x - 10, cy - 40, TRUE);
}

void CBrowserDlg::OnClose() {
	DestroyWindow();
}

void CBrowserDlg::OnDestroy() {
	// When the main dialog is destroyed, quit the application.
	//
	PostQuitMessage(0);
}

void CBrowserDlg::doNothing() {
}

LRESULT CBrowserDlg::WindowProc(UINT message, WPARAM wparam, LPARAM lparam) {
	return CDialog::WindowProc(message, wparam, lparam);
}

void CBrowserDlg::OnTimer(UINT_PTR nIDEvent) {
	if (nIDEvent == 0) {
		KillTimer(0);
		go();
	}
}

// Gets the text in the url edit control.  The caller must free it.
//
wchar_t* CBrowserDlg::getUrlText() {
	CWnd* item = GetDlgItem(IDC_EDITURL);
	int len = (int)item->SendMessage(WM_GETTEXTLENGTH, 0, 0);

	wchar_t* text = new wchar_t[len + 1];
	item->SendMessage(WM_GETTEXT, (WPARAM)len + 1, (LPARAM)text);
	return text;
}

// Loads the document specified by the url edit control.
//
void CBrowserDlg::go() {
	wchar_t* url = getUrlText();
	m_explorer.Navigate(url, 0, 0, 0, 0);
	delete[] url;
}

void CBrowserDlg::OnBnClickedBack() {
	m_explorer.GoBack();
}

void CBrowserDlg::OnBnClickedForward() {
	m_explorer.GoForward();
}

void CBrowserDlg::OnBnClickedGo() {
	if (m_waitingForDoc) {
		// (The button says 'stop')
		//   If waiting for a document, cancel it, set the button back to
		//   'go', and enable the leak test and blow memory buttons.
		//
		m_waitingForDoc = false;
		GetDlgItem(IDC_GO)->SendMessage(WM_SETTEXT, 0, (LPARAM)L"Go");
		GetDlgItem(IDC_DRIP)->EnableWindow(TRUE);
		GetDlgItem(IDC_BLOW)->EnableWindow(TRUE);
		m_explorer.Stop();
	}
	else {
		// (The button says 'go')
		//   Load the specified document, set the button to 'stop', and
		//   disable the leak test and blow memory buttons.
		//
		m_waitingForDoc = true;
		GetDlgItem(IDC_GO)->SendMessage(WM_SETTEXT, 0, (LPARAM)L"Stop");
		GetDlgItem(IDC_DRIP)->EnableWindow(FALSE);
		GetDlgItem(IDC_BLOW)->EnableWindow(FALSE);
		go();
	}
}

void CBrowserDlg::OnBnClickedCheckLeaks() {
	// When the leak test button is pressed, navigate to the blank document
	//   so that the browser will release all of its elements.  Set
	//   m_waitingForBlankDoc to true so that the DocumentComplete event
	//   handler will know to check for leaks when the blank document
	//   finishes loading.
	//
	m_explorer.Navigate(L"about:blank", NULL, NULL, NULL, NULL);
	m_waitingForBlankDoc = true;
}

void CBrowserDlg::OnBnClickedBlow() {
	if (!m_blowMode) {
		// (The button says 'blow memory')
		//   Start blowing memory, change the button to 'stop', and disable
		//   the go and leak test buttons.
		//
		m_blowMode = true;
		GetDlgItem(IDC_BLOW)->SendMessage(WM_SETTEXT, 0, (LPARAM)L"Stop");
		GetDlgItem(IDC_GO)->EnableWindow(FALSE);
		GetDlgItem(IDC_DRIP)->EnableWindow(FALSE);
		GetDlgItem(IDC_MEMLIST)->SendMessage(LB_RESETCONTENT, 0, 0);

		// Load the specified document, which will start the memory-blowing cycle.
		//
		go();
	}
	else {
		// (The button says 'stop')
		//   Stop blowing memory, change the button back to 'blow memory', and
		//   re-enable the go and leak test buttons.
		//
		m_blowMode = false;
		GetDlgItem(IDC_BLOW)->SendMessage(WM_SETTEXT, 0, (LPARAM)L"Blow Memory");
		GetDlgItem(IDC_GO)->EnableWindow(TRUE);
		GetDlgItem(IDC_DRIP)->EnableWindow(TRUE);
	}
}

// This event is fired whenever the document (or any of its frames) is fully
//   loaded (meaning that its HTML has been parsed and all elements created).
//
void CBrowserDlg::DocumentCompleteExplorer(LPDISPATCH pDisp, VARIANT* URL) {
	// pDisp is the IWebBrowser2 control sending the DocumentComplete event.
	//   (it may not be the main control, if the document being loaded
	//   contains frames).
	//
	IWebBrowser2* sender = NULL;
	pDisp->QueryInterface(IID_IWebBrowser2, (void**)&sender);

	// Get the document interface from the browser control.
	//
	IDispatch* dispDoc = NULL;
	sender->get_Document(&dispDoc);
	if (!dispDoc)
		return;

	MSHTML::IHTMLDocument2Ptr doc = dispDoc;

	// If we're waiting for a normal document, hook all of its static elements.
	//
	if (m_waitingForDoc && !m_blowMode)
		m_hook->addStaticElements(doc->parentWindow);

	// Determine whether the completed document is the outer one that we are
	//   actually waiting on (by comparing its URL with the outer browser's).
	//
	BSTR loadedLocation = NULL;
	sender->get_LocationURL(&loadedLocation);

	CString outerLocation = m_explorer.GetLocationURL();
	bool isOuter = (0 == outerLocation.Compare(loadedLocation));

	SysFreeString(loadedLocation);
	sender->Release();

	if (!isOuter)
		return;

	// If we're in 'blow memory' mode, display the current memory usage
	//   and refresh the document.
	//
	if (m_blowMode) {
		// Make sure that the browser's GC pass is done so that we don't report
		//   as-yet-uncollected memory.
		//
		doc->parentWindow->execScript(L"window.CollectGarbage()", L"javascript");

		// Get the process' memory usage and add it to the list.
		//
		PROCESS_MEMORY_COUNTERS procMem;
		memset(&procMem, 0, sizeof(PROCESS_MEMORY_COUNTERS));
		procMem.cb = sizeof(PROCESS_MEMORY_COUNTERS);
		GetProcessMemoryInfo(GetCurrentProcess(), &procMem, procMem.cb);

		wchar_t memText[32];
		_itow((int)procMem.WorkingSetSize, memText, 10);
		GetDlgItem(IDC_MEMLIST)->SendMessage(LB_ADDSTRING, 0, (LPARAM)memText);

		// Reload the document in 500 ms.
		//
		SetTimer(0, 500, NULL);
	}

	// If we're waiting for a blank document (that is, we're waiting for the
	//   current document to fully unload so that we can check for leaks),
	//   then check for leaks and display the leak dialog.
	//
	else if (m_waitingForBlankDoc) {
		m_waitingForBlankDoc = false;
		CLeakDlg leakDlg(this);
		m_hook->showLeaks(doc->parentWindow, &leakDlg);
		GetDlgItem(IDC_CHECKLEAKS)->EnableWindow(FALSE);
		leakDlg.DoModal();
	}

	// If we're simply waiting on the page to load, re-enable the drip, leak
	//   test, and blow buttons, and set the 'stop' button back to 'go'.
	//
	else {
		GetDlgItem(IDC_DRIP)->EnableWindow(TRUE);
		GetDlgItem(IDC_BLOW)->EnableWindow(TRUE);
		GetDlgItem(IDC_GO)->SendMessage(WM_SETTEXT, 0, (LPARAM)L"Go");
		GetDlgItem(IDC_CHECKLEAKS)->EnableWindow(TRUE);
		m_waitingForDoc = false;
	}
}

// This event is fired when the document has been downloaded but not yet parsed
//   (nor its onload event fired).
//
void CBrowserDlg::NavigateComplete2Explorer(LPDISPATCH pDisp, VARIANT* URL) {
	// If we're waiting on the document (but not blowing memory), hook its
	//   createElement() method, so that we can collect all dynamically-
	//   created elements.
	//
	if (m_waitingForDoc && !m_blowMode) {
		IWebBrowser2* sender = NULL;
		pDisp->QueryInterface(IID_IWebBrowser2, (void**)&sender);

		IDispatch* dispDoc = NULL;
		sender->get_Document(&dispDoc);
		MSHTML::IHTMLDocument2Ptr doc = dispDoc;
		m_hook->hookNewPage(doc);
	}
}

void CBrowserDlg::NewWindow3Explorer(LPDISPATCH* ppDisp, BOOL* Cancel, unsigned long dwFlags, LPCTSTR bstrUrlContext, LPCTSTR bstrUrl) {
	// TODO: figure out how to hook the new window.
}
