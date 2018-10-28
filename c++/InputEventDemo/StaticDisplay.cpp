// StaticDisplay.cpp : implementation file
//

#include "stdafx.h"
#include "InputEventDemo.h"
#include "StaticDisplay.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
#include "InputEvent.h"
/////////////////////////////////////////////////////////////////////////////
// CStaticDisplay

CStaticDisplay::CStaticDisplay()
{
}

CStaticDisplay::~CStaticDisplay()
{
	// free memory
	delete m_pInputEvent;
}


BEGIN_MESSAGE_MAP(CStaticDisplay, CStatic)
	//{{AFX_MSG_MAP(CStaticDisplay)
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStaticDisplay message handlers

BOOL CStaticDisplay::PreTranslateMessage(MSG* pMsg) 
{
	//--------------------------------------------------
	// Pass message to CInputEvent and relay it or not to mother class
	//--------------------------------------------------
	m_pInputEvent->RelayMsg(pMsg);
	return CStatic::PreTranslateMessage(pMsg);
}

void CStaticDisplay::PreSubclassWindow() 
{
	//--------------------------------------------------
	// Init InputEvents
	//--------------------------------------------------
	m_pInputEvent = new CInputEvent(this);
	CStatic::PreSubclassWindow();
}



void CStaticDisplay::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	
	// Gets rect and DC
	CDC* pDC=&dc;
	CRect	rect;
	GetClientRect(&rect);

	// Gets Mouse & keyborad status
	CInputEvent::INPUTSTATUS ips;
	m_pInputEvent->GetStatus(&ips);
	CString	str;

	// Button is disabled
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
	
	pDC->FillSolidRect(&ips.rect, RGB(100,200,255));
	pDC->DrawText(str, &ips.rect, DT_CENTER|DT_VCENTER|DT_SINGLELINE);

}
