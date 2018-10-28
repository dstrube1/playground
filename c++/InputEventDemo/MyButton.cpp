// MyButton.cpp : implementation file
//

#include "stdafx.h"
#include "InputEventDemo.h"
#include "MyButton.h"

#include "InputEvent.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMyButton

CMyButton::CMyButton()
{
}

CMyButton::~CMyButton()
{
	// free memory
	delete m_pInputEvent;
}


BEGIN_MESSAGE_MAP(CMyButton, CButton)
	//{{AFX_MSG_MAP(CMyButton)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMyButton message handlers

BOOL CMyButton::PreTranslateMessage(MSG* pMsg) 
{
	//--------------------------------------------------
	// Pass message to CInputEvent and relay it or not to mother class
	//--------------------------------------------------
	m_pInputEvent->RelayMsg(pMsg);
	return CButton::PreTranslateMessage(pMsg);
	

}

void CMyButton::PreSubclassWindow() 
{
	//--------------------------------------------------
	// Init InputEvents
	//--------------------------------------------------
	m_pInputEvent = new CInputEvent(this);
	CButton::PreSubclassWindow();
}



void CMyButton::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) 
{
	// Gets Button status
	CInputEvent::INPUTSTATUS ips;
	m_pInputEvent->GetStatus(&ips);
	CString	str;


	// Gets DC
	CDC* pDC=CDC::FromHandle(lpDrawItemStruct->hDC);

	// Button is disabled
	if (lpDrawItemStruct->itemState & ODS_DISABLED)
	{
		str="Disabled";
	}
	else
	{
		switch (ips.drawPosition)
		{
		case 1: //CInputEvent::DRAW_NORMAL:
			str="Normal";
			break;
		case 2: //CInputEvent::DRAW_OVER:
			str="Over";
			break;
		case 3: //CInputEvent::DRAW_PUSHED:
			str="Pushed";
			break;
		}
	}
	
	pDC->FillSolidRect(&ips.rect, RGB(100,200,255));
	pDC->DrawText(str, &ips.rect, DT_CENTER|DT_VCENTER|DT_SINGLELINE);

	
}




