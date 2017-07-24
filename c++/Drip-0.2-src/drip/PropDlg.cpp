#include "stdafx.h"
#include "resource.h"
#include "PropDlg.hpp"
#include ".\propdlg.hpp"

CPropDlg::CPropDlg(CWnd* pParent) : CDialog(CPropDlg::IDD, pParent) {
	//{{AFX_DATA_INIT(CPropDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

void CPropDlg::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);

	//{{AFX_DATA_MAP(CPropDlg)
	DDX_Control(pDX, IDC_PROPLIST, m_propList);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CPropDlg, CDialog)
	//{{AFX_MSG_MAP(CPropDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_SIZE()
	ON_WM_CLOSE()
	ON_WM_DESTROY()
	ON_BN_CLICKED(IDOK, OnOk)
	//}}AFX_MSG_MAP
	ON_NOTIFY(LVN_ITEMACTIVATE, IDC_PROPLIST, OnLvnItemActivateProplist)
END_MESSAGE_MAP()

BOOL CPropDlg::OnInitDialog() {
	CDialog::OnInitDialog();

	// Set up the name/value colums for the property list.
	//
	m_propList.InsertColumn(0, L"Name", LVCFMT_LEFT, 128);
	m_propList.InsertColumn(1, L"Value", LVCFMT_LEFT, 384);

	// Iterate over all of the object's properties.
	//
	DISPID dispId = 0;
	HRESULT hr = m_object->GetNextDispID(fdexEnumAll, DISPID_STARTENUM, &dispId);
	while (SUCCEEDED(hr) && (hr != S_FALSE)) {
		BSTR memberName = NULL;
		if (SUCCEEDED(m_object->GetMemberName(dispId, &memberName))) {
			// Invoke the property get to get the property's value.
			//
			DISPPARAMS params;
			VARIANT result;
			memset(&params, 0, sizeof(DISPPARAMS));
			VariantInit(&result);
			if (SUCCEEDED(m_object->Invoke(dispId, IID_NULL, LOCALE_SYSTEM_DEFAULT, DISPATCH_PROPERTYGET,
				&params, &result, NULL, NULL))) {

				// Add the new property to the list, changing the value to a string.
				//
				int itemIdx = m_propList.InsertItem(0, memberName);
				m_propList.SetItemData(itemIdx, (DWORD_PTR)dispId);

				if (result.vt == VT_DISPATCH)
					m_propList.SetItemText(itemIdx, 1, L"[object...]");
				else {
					VariantChangeType(&result, &result, 0, VT_BSTR);
					if ((result.vt == VT_BSTR) && (result.bstrVal != NULL))
						m_propList.SetItemText(itemIdx, 1, result.bstrVal);
				}
			}

			SysFreeString(memberName);
		}

		hr = m_object->GetNextDispID(fdexEnumAll, dispId, &dispId);
	}

	return TRUE;
}

VARIANT CPropDlg::getPropValue(int idx) {
	// Invoke the property get to get the property's value.
	//
	DISPPARAMS params;
	VARIANT result;
	memset(&params, 0, sizeof(DISPPARAMS));
	VariantInit(&result);

	DISPID dispId = (DISPID)m_propList.GetItemData(idx);
	m_object->Invoke(dispId, IID_NULL, LOCALE_SYSTEM_DEFAULT, DISPATCH_PROPERTYGET, &params, &result, NULL, NULL);
	return result;
}

void CPropDlg::OnClose() {
	EndDialog(0);
}

void CPropDlg::OnOk() {
	EndDialog(0);
}

void CPropDlg::OnDestroy() {
}

void CPropDlg::setObject(CComPtr<IDispatchEx> obj) {
	m_object = obj;
}

void CPropDlg::OnLvnItemActivateProplist(NMHDR *pNMHDR, LRESULT *pResult) {
	LPNMITEMACTIVATE NMIA = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);

	// Get the IDispatch interface so that we can dynamically query the
	//   element's properties.
	//
	VARIANT value = getPropValue(NMIA->iItem);
	if (value.vt == VT_DISPATCH) {
		CPropDlg propDlg(this);
		CComQIPtr<IDispatchEx> dispEx = value.pdispVal;
		if (dispEx) {
			propDlg.setObject(dispEx);
			propDlg.DoModal();
		}
	}

	VariantClear(&value);
}
