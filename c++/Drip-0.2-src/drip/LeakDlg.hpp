#pragma once

#include "resource.h"
#include "WebBrowser2.hpp"
#include "JSHook.hpp"

// This structure is used to keep track of leaked elements, the URL of their
//  documents, and the number of references left outstanding.
//
struct LeakEntry {
	LeakEntry(IUnknown* elem, BSTR url, int refCount) {
		this->elem = elem;
		this->url = url;
		this->refCount = refCount;
	}

	IUnknown*	elem;
	BSTR		url;
	int			refCount;
};

// The dialog box for displaying all leaked elements.
//
class CLeakDlg : public CDialog {
private:
	enum { IDD = IDD_LEAKS };
	CListCtrl				m_leakList;
	std::vector<LeakEntry>	m_leaks;

	void clearLeaks();
	void populateLeaks();

public:
    CLeakDlg(CWnd* pParent = NULL);
	void addElement(IUnknown* elem, BSTR url, int refCount);

	DECLARE_MESSAGE_MAP()

	virtual void DoDataExchange(CDataExchange* pDX);
	virtual BOOL OnInitDialog();
	afx_msg void OnClose();
	afx_msg void OnDestroy();
	afx_msg void OnOk();
	afx_msg void OnLvnItemActivateLeaklist(NMHDR *pNMHDR, LRESULT *pResult);
};
