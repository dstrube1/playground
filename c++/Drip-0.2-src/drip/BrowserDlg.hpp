#pragma once

#include "resource.h"
#include "WebBrowser2.hpp"
#include "JSHook.hpp"

// The main drip dialog box, containing the browser control.
//
class CBrowserDlg : public CDialog {
private:
	wchar_t* getUrlText();
	void go();

	CComObject<JSHook>*			m_hook;

	CWebBrowser2				m_explorer;

	bool						m_waitingForDoc;
	bool						m_waitingForBlankDoc;
	bool						m_blowMode;

	HICON						m_hIcon;

public:
	enum { IDD = IDD_BROWSER_DIALOG };

    CBrowserDlg(CWnd* pParent = NULL);
	virtual ~CBrowserDlg();

	DECLARE_MESSAGE_MAP()

    LRESULT WindowProc(UINT message, WPARAM wparam, LPARAM lparam);
	virtual void DoDataExchange(CDataExchange* pDX);
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void doNothing();
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnClose();
	afx_msg void OnDestroy();
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	afx_msg void OnBnClickedGo();
	afx_msg void OnBnClickedBack();
	afx_msg void OnBnClickedForward();
	afx_msg void OnBnClickedCheckLeaks();
	DECLARE_EVENTSINK_MAP()
	void DocumentCompleteExplorer(LPDISPATCH pDisp, VARIANT* URL);
	afx_msg void OnBnClickedBlow();
	void NavigateComplete2Explorer(LPDISPATCH pDisp, VARIANT* URL);
	void NewWindow3Explorer(LPDISPATCH* ppDisp, BOOL* Cancel, unsigned long dwFlags, LPCTSTR bstrUrlContext, LPCTSTR bstrUrl);
};
