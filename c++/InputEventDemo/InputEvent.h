// InputEvent.h: interface for the CInputEvent class.
//
//////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////
class CInputEvent  
{

	//--------------------------------------------------
	// Input Status Structure
	//--------------------------------------------------
public:

	typedef enum
	{
		DRAW_NORMAL=	1,
		DRAW_OVER=		2,
		DRAW_PUSHED=	3,
		DRAW_DISABLED=	4
	} CWND_STATE_t;


	typedef struct INPUTSTATUS
	{
		bool			leftButton;			// Left mouse button is pressd
		bool			rightButton;		// Right mouse button is pressd
		bool			middleButton;		// Middle mouse button is pressd
		bool			mouseOver;			// Mouse is over the control
		int				posX;				// x-coord of mouse
		int				posY;				// y-coord of mouse
		bool			ctrl;				// Control button is pressed
		bool			shift;				// Shift button is pressed
		CRect			rect;				// Client Rect
		CWND_STATE_t	drawPosition;		// Indicates what is the current position
	};


	//--------------------------------------------------
	// CONSTRUCTOR / DESTRUCTOR
	//--------------------------------------------------
public:
	CInputEvent	(CWnd* pWnd);
	virtual		~CInputEvent();



	//--------------------------------------------------
	// MEMBER DATA
	//--------------------------------------------------
public:
	CWnd*			m_pWnd;				// Pointer to the CWnd button

protected:
	TRACKMOUSEEVENT m_TrackMouseEvent;	// Track Mouse Event
	INPUTSTATUS		m_InputStatus;		// Mouse Keybord Status

	//--------------------------------------------------
	// MEMBER FUNCTIONS
	//--------------------------------------------------
public:
	void	GetStatus				(INPUTSTATUS* ips);
	void	RelayMsg				(MSG* pMsg);

protected:
	void	FillData		(WPARAM wParam, LPARAM lParam);	// Update m_InputEvent daa with current state
	void	ClearData		();								// Clear m_InputEvent data
};
