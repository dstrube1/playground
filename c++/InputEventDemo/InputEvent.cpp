// InputEvent.cpp: implementation of the CInputEvent class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "InputEvent.h"


//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CInputEvent::CInputEvent(CWnd* pWnd)
{
	m_pWnd=	pWnd;

	m_TrackMouseEvent.cbSize=		sizeof(TRACKMOUSEEVENT); 
	m_TrackMouseEvent.hwndTrack=	m_pWnd->m_hWnd;
	m_TrackMouseEvent.dwFlags=		NULL;
	m_TrackMouseEvent.dwHoverTime=	0;


	m_InputStatus.ctrl=			false;
	m_InputStatus.shift=		false;
	m_InputStatus.leftButton=	false;
	m_InputStatus.middleButton=	false;
	m_InputStatus.rightButton=	false;
	m_InputStatus.posX=			0;
	m_InputStatus.posY=			0;
	m_InputStatus.mouseOver=	false;
	m_InputStatus.drawPosition=	DRAW_NORMAL;
	m_InputStatus.rect.SetRectEmpty();

}

CInputEvent::~CInputEvent()
{
}

////////////////////////////////////////////////////////////////////////////////
// Function : RelayMsg
// In		: -
// Out		: -
// Desc.	: Processes the messages
////////////////////////////////////////////////////////////////////////////////
void CInputEvent::RelayMsg(MSG *pMsg)
{

	bool bNeedToInvalidate=false;
	switch (pMsg->message)
	{
		//--------------------------------------------------
		// MOUSE MOVE
		//--------------------------------------------------
		case WM_MOUSEMOVE:
			{

				// Sets Initial values
				bool bCapturing = GetCapture()  == m_pWnd->m_hWnd ;	// We are capturing this button
				bool bCapturingIn;									// We are capturing this button AND over it


				// We are in Capture mode, means button was pressed and not released
				if (bCapturing)
				{
				// Gets if we're capturing out or over
					CPoint mousePoint(m_InputStatus.posX, m_InputStatus.posY);
					m_pWnd->ClientToScreen(&mousePoint);
					bCapturingIn= WindowFromPoint(mousePoint) == m_pWnd->m_hWnd;

					if (bCapturingIn)
					{
						// mouse is over the button, draws as Pushed
						m_InputStatus.drawPosition=DRAW_PUSHED;
						// mouse has just come over, invalidate button
						if (!m_InputStatus.mouseOver)
							bNeedToInvalidate=true;
						m_InputStatus.mouseOver=true;
					}
					else
					{
						// mouse is out of the button, draws as Normal
						m_InputStatus.drawPosition=DRAW_NORMAL;
						// mouse has just leaves , invalidate button
						if (m_InputStatus.mouseOver)
							bNeedToInvalidate=true;
						m_InputStatus.mouseOver=false;
					}

				}
				else
				{
					// We are not in Capture mode, draws as Over and post WM_MOUSELEAVE if moves out
					m_InputStatus.drawPosition=DRAW_OVER;
					// mouse has just comes over , invalidate button
					if (!m_InputStatus.mouseOver)
						bNeedToInvalidate=true;
					m_InputStatus.mouseOver=true;
					m_TrackMouseEvent.dwFlags = TME_LEAVE;
					_TrackMouseEvent(&m_TrackMouseEvent);
				}

				// Sets values
				FillData(pMsg->wParam, pMsg->lParam);				// Fill data structure

			}

		break;

		case WM_MOUSELEAVE:
			ClearData();
			m_InputStatus.mouseOver=false;
			m_InputStatus.drawPosition=DRAW_NORMAL;
			bNeedToInvalidate=true;
			break;


		//--------------------------------------------------
		// LEFT BUTTON
		//--------------------------------------------------
		case WM_LBUTTONDOWN:
			FillData(pMsg->wParam, pMsg->lParam);
			m_InputStatus.drawPosition=DRAW_PUSHED;
			bNeedToInvalidate=true;
			break;

		case WM_LBUTTONUP:
			FillData(pMsg->wParam, pMsg->lParam);
			m_InputStatus.drawPosition=DRAW_OVER;
			bNeedToInvalidate=true;
			break;

		case WM_LBUTTONDBLCLK:
			//No double click on a push button
			bNeedToInvalidate=true;
			m_InputStatus.drawPosition=DRAW_PUSHED;
			break;

		//-------------------------------------------------------
		// Manage here all the Windows Message you need
		// for wheelmouse, right button, keyboard entry etc...
	}
	
	//--------------------------------------------------
	// Invalidate window if needed
	//--------------------------------------------------
	if (bNeedToInvalidate)
		m_pWnd->Invalidate();
}



////////////////////////////////////////////////////////////////////////////////
// Function : GetStatus
// In		: - INPUTSTATUS*
// Out		: - 
// Desc.	: Copy the current InputData to the required one
////////////////////////////////////////////////////////////////////////////////
void CInputEvent::GetStatus(CInputEvent::INPUTSTATUS* pInputStatus)
{
	m_pWnd->GetClientRect(&m_InputStatus.rect);
	*pInputStatus=m_InputStatus;
	
}

////////////////////////////////////////////////////////////////////////////////
// Function : FillData
// In		: -
// Out		: -
// Desc.	: Fills the INPUTSTATUS data with the current status
////////////////////////////////////////////////////////////////////////////////
void CInputEvent::FillData(WPARAM wParam, LPARAM lParam)
{
	m_InputStatus.ctrl	=		( (wParam & MK_CONTROL)	== MK_CONTROL );
	m_InputStatus.shift	=		( (wParam & MK_SHIFT)	== MK_SHIFT	  );
	m_InputStatus.leftButton=	( (wParam & MK_LBUTTON)	== MK_LBUTTON );
	m_InputStatus.middleButton= ( (wParam & MK_MBUTTON)	== MK_MBUTTON );
	m_InputStatus.rightButton=	( (wParam & MK_RBUTTON)	== MK_RBUTTON );

	m_InputStatus.posX = LOWORD(lParam);
	m_InputStatus.posY = HIWORD(lParam);

}
////////////////////////////////////////////////////////////////////////////////
// Function : ClearData
// In		: -
// Out		: -
// Desc.	: Clear m_InputEvent data
////////////////////////////////////////////////////////////////////////////////
void CInputEvent::ClearData()
{
	m_InputStatus.ctrl	=		false;
	m_InputStatus.shift	=		false;
	m_InputStatus.mouseOver=	false;
	m_InputStatus.leftButton=	false;
	m_InputStatus.middleButton= false;
	m_InputStatus.rightButton=	false;
	m_InputStatus.posX =		0;
	m_InputStatus.posY =		0;
	m_InputStatus.rect.SetRectEmpty();
}


