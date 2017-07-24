// InputEventDemoDlg.h : header file
//

#if !defined(AFX_INPUTEVENTDEMODLG_H__CD8011A1_8650_4093_8DB0_509592B97F35__INCLUDED_)
#define AFX_INPUTEVENTDEMODLG_H__CD8011A1_8650_4093_8DB0_509592B97F35__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "MyButton.h"
#include "StaticDisplay.h"

/////////////////////////////////////////////////////////////////////////////
// CInputEventDemoDlg dialog

class CInputEventDemoDlg : public CDialog
{
// Construction
public:
	CInputEventDemoDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CInputEventDemoDlg)
	enum { IDD = IDD_INPUTEVENTDEMO_DIALOG };
	CStaticDisplay	m_Static;
	CMyButton	m_MyButton;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInputEventDemoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CInputEventDemoDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INPUTEVENTDEMODLG_H__CD8011A1_8650_4093_8DB0_509592B97F35__INCLUDED_)
