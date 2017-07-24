#if !defined(AFX_STATICDISPLAY_H__13E38AE9_99CC_4E56_8E76_35D695A09CD3__INCLUDED_)
#define AFX_STATICDISPLAY_H__13E38AE9_99CC_4E56_8E76_35D695A09CD3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StaticDisplay.h : header file
//
class CInputEvent;

/////////////////////////////////////////////////////////////////////////////
// CStaticDisplay window

class CStaticDisplay : public CStatic
{
// Construction
public:
	CStaticDisplay();

// Attributes
public:
	CInputEvent* m_pInputEvent;

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStaticDisplay)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	protected:
	virtual void PreSubclassWindow();
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CStaticDisplay();

	// Generated message map functions
protected:
	//{{AFX_MSG(CStaticDisplay)
	afx_msg void OnPaint();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STATICDISPLAY_H__13E38AE9_99CC_4E56_8E76_35D695A09CD3__INCLUDED_)
