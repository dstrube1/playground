#include "stdafx.h"
#include "resource.h"
#include "LeakDlg.hpp"
#include "PropDlg.hpp"

CLeakDlg::CLeakDlg(CWnd* pParent) : CDialog(CLeakDlg::IDD, pParent) {
	//{{AFX_DATA_INIT(CLeakDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

void CLeakDlg::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);

	//{{AFX_DATA_MAP(CLeakDlg)
	DDX_Control(pDX, IDC_LEAKLIST, m_leakList);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CLeakDlg, CDialog)
	//{{AFX_MSG_MAP(CLeakDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_SIZE()
	ON_WM_CLOSE()
	ON_WM_DESTROY()
	ON_BN_CLICKED(IDOK, OnOk)
	//}}AFX_MSG_MAP
	ON_NOTIFY(LVN_ITEMACTIVATE, IDC_LEAKLIST, OnLvnItemActivateLeaklist)
END_MESSAGE_MAP()

BOOL CLeakDlg::OnInitDialog() {
	CDialog::OnInitDialog();

	// Set up the columns for the leak list.
	//
	m_leakList.InsertColumn(0, L"URL", LVCFMT_LEFT, 128);
	m_leakList.InsertColumn(1, L"Refs", LVCFMT_LEFT, 40);
	m_leakList.InsertColumn(2, L"Tag", LVCFMT_LEFT, 64);
	m_leakList.InsertColumn(3, L"Id", LVCFMT_LEFT, 128);
	m_leakList.InsertColumn(4, L"Class", LVCFMT_LEFT, 256);

	// Populate the leak list control from the list of LeakEntry structures.
	//
	populateLeaks();

	return TRUE;
}

void CLeakDlg::OnClose() {
	EndDialog(0);
}

void CLeakDlg::OnOk() {
	EndDialog(0);
}

void CLeakDlg::OnDestroy() {
	// Free the leak list when the dialog is destroyed.
	//
	clearLeaks();
}

// Adds an element to the leak list, including its document URL and ref count.
//
void CLeakDlg::addElement(IUnknown* elem, BSTR url, int refCount) {
	// Add a reference to the element, and allocate a copy of the URL string.
	//
	elem->AddRef();
	m_leaks.push_back(LeakEntry(elem, SysAllocString(url), refCount));
}

// Clear all leaks.
//
void CLeakDlg::clearLeaks() {
	for (std::vector<LeakEntry>::const_iterator it = m_leaks.begin(); it != m_leaks.end(); ++it) {
		// Release the leaked element and free its associated document URL.
		//   (of course, since this element is over-referenced, it won't actually get freed
		//   properly, but we're doing our part, at least!)
		//
		it->elem->Release();
		SysFreeString(it->url);
	}
	m_leaks.clear();
}

// Take all entries in m_leaks and populate the leak list control with them.
//
void CLeakDlg::populateLeaks() {
	int idx = 0;
	for (std::vector<LeakEntry>::const_iterator it = m_leaks.begin(); it != m_leaks.end(); ++it, ++idx) {
		LeakEntry const& entry = *it;
		MSHTML::IHTMLElementPtr elem = entry.elem;

		wchar_t refCountText[32];
		_itow(entry.refCount, refCountText, 10);

		m_leakList.InsertItem(idx, entry.url);
		m_leakList.SetItemText(idx, 1, refCountText);
		m_leakList.SetItemText(idx, 2, elem->tagName);
		m_leakList.SetItemText(idx, 3, elem->id);
		m_leakList.SetItemText(idx, 4, elem->className);
	}
}

// When a leaked element is selected, display its properties.
//
afx_msg void CLeakDlg::OnLvnItemActivateLeaklist(NMHDR *pNMHDR, LRESULT *pResult) {
	LPNMLISTVIEW pNMLV = reinterpret_cast<LPNMLISTVIEW>(pNMHDR);

	// Get the IDispatch interface so that we can dynamically query the
	//   element's properties.
	//
	LeakEntry& entry = m_leaks.at(pNMLV->iItem);
	CComQIPtr<IDispatchEx> disp = entry.elem;

	CPropDlg propDlg(this);
	propDlg.setObject(disp);
	propDlg.DoModal();
}
