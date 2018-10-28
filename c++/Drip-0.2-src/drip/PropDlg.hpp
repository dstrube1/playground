#pragma once

#include "resource.h"
#include "WebBrowser2.hpp"
#include "JSHook.hpp"

// A dialog box for displaying an object's properties and their values.
//
class CPropDlg : public CDialog {
private:
	enum { IDD = IDD_PROPERTIES };
	CListCtrl				m_propList;
	CComPtr<IDispatchEx>	m_object;

	VARIANT getPropValue(int idx);

public:
    CPropDlg(CWnd* pParent = NULL);
	void setObject(CComPtr<IDispatchEx> obj);

	DECLARE_MESSAGE_MAP()

	virtual void DoDataExchange(CDataExchange* pDX);
	virtual BOOL OnInitDialog();
	afx_msg void OnClose();
	afx_msg void OnDestroy();
	afx_msg void OnOk();
	afx_msg void OnLvnItemActivateProplist(NMHDR *pNMHDR, LRESULT *pResult);
};
