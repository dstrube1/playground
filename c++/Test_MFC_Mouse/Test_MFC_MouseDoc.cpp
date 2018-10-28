// Test_MFC_MouseDoc.cpp : implementation of the CTest_MFC_MouseDoc class
//

#include "stdafx.h"
#include "Test_MFC_Mouse.h"

#include "Test_MFC_MouseDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CTest_MFC_MouseDoc

IMPLEMENT_DYNCREATE(CTest_MFC_MouseDoc, CDocument)

BEGIN_MESSAGE_MAP(CTest_MFC_MouseDoc, CDocument)
END_MESSAGE_MAP()


// CTest_MFC_MouseDoc construction/destruction

CTest_MFC_MouseDoc::CTest_MFC_MouseDoc()
{
	// TODO: add one-time construction code here

}

CTest_MFC_MouseDoc::~CTest_MFC_MouseDoc()
{
}

BOOL CTest_MFC_MouseDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)

	return TRUE;
}




// CTest_MFC_MouseDoc serialization

void CTest_MFC_MouseDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: add storing code here
	}
	else
	{
		// TODO: add loading code here
	}
}


// CTest_MFC_MouseDoc diagnostics

#ifdef _DEBUG
void CTest_MFC_MouseDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CTest_MFC_MouseDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CTest_MFC_MouseDoc commands
