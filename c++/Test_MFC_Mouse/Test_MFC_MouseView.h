// Test_MFC_MouseView.h : interface of the CTest_MFC_MouseView class
//


#pragma once


class CTest_MFC_MouseView : public CView
{
protected: // create from serialization only
	CTest_MFC_MouseView();
	DECLARE_DYNCREATE(CTest_MFC_MouseView)

// Attributes
public:
	CTest_MFC_MouseDoc* GetDocument() const;

// Operations
public:

// Overrides
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:

// Implementation
public:
	virtual ~CTest_MFC_MouseView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in Test_MFC_MouseView.cpp
inline CTest_MFC_MouseDoc* CTest_MFC_MouseView::GetDocument() const
   { return reinterpret_cast<CTest_MFC_MouseDoc*>(m_pDocument); }
#endif

