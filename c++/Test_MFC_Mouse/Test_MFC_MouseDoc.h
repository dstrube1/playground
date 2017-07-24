// Test_MFC_MouseDoc.h : interface of the CTest_MFC_MouseDoc class
//


#pragma once

class CTest_MFC_MouseDoc : public CDocument
{
protected: // create from serialization only
	CTest_MFC_MouseDoc();
	DECLARE_DYNCREATE(CTest_MFC_MouseDoc)

// Attributes
public:

// Operations
public:

// Overrides
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);

// Implementation
public:
	virtual ~CTest_MFC_MouseDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	DECLARE_MESSAGE_MAP()
};


