// Test_MFC_MouseView.cpp : implementation of the CTest_MFC_MouseView class
//

#include "stdafx.h"
#include "Test_MFC_Mouse.h"

#include "Test_MFC_MouseDoc.h"
#include "Test_MFC_MouseView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CTest_MFC_MouseView

IMPLEMENT_DYNCREATE(CTest_MFC_MouseView, CView)

BEGIN_MESSAGE_MAP(CTest_MFC_MouseView, CView)
END_MESSAGE_MAP()

// CTest_MFC_MouseView construction/destruction

CTest_MFC_MouseView::CTest_MFC_MouseView()
{
	// TODO: add construction code here

}

CTest_MFC_MouseView::~CTest_MFC_MouseView()
{
}

BOOL CTest_MFC_MouseView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return CView::PreCreateWindow(cs);
}

// CTest_MFC_MouseView drawing

void CTest_MFC_MouseView::OnDraw(CDC* /*pDC*/)
{
	CTest_MFC_MouseDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	// TODO: add draw code for native data here
}


// CTest_MFC_MouseView diagnostics

#ifdef _DEBUG
void CTest_MFC_MouseView::AssertValid() const
{
	CView::AssertValid();
}

void CTest_MFC_MouseView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CTest_MFC_MouseDoc* CTest_MFC_MouseView::GetDocument() const // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CTest_MFC_MouseDoc)));
	return (CTest_MFC_MouseDoc*)m_pDocument;
}
#endif //_DEBUG


// CTest_MFC_MouseView message handlers
