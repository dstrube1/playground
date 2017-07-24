; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CInputEventDemoDlg
LastTemplate=CStatic
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "InputEventDemo.h"

ClassCount=4
Class1=CInputEventDemoApp
Class2=CInputEventDemoDlg

ResourceCount=3
Resource2=IDD_INPUTEVENTDEMO_DIALOG
Resource1=IDR_MAINFRAME
Class3=CMyButton
Class4=CStaticDisplay
Resource3=IDD_INPUTEVENTDEMO_DIALOG (English (U.S.))

[CLS:CInputEventDemoApp]
Type=0
HeaderFile=InputEventDemo.h
ImplementationFile=InputEventDemo.cpp
Filter=N

[CLS:CInputEventDemoDlg]
Type=0
HeaderFile=InputEventDemoDlg.h
ImplementationFile=InputEventDemoDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=IDC_SIMPLE_STATIC



[DLG:IDD_INPUTEVENTDEMO_DIALOG]
Type=1
ControlCount=3
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Class=CInputEventDemoDlg

[DLG:IDD_INPUTEVENTDEMO_DIALOG (English (U.S.))]
Type=1
Class=CInputEventDemoDlg
ControlCount=5
Control1=IDOK,button,1342242817
Control2=IDC_BUTTON,button,1342242827
Control3=IDC_SIMPLE_STATIC,static,1342312704
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308352

[CLS:CMyButton]
Type=0
HeaderFile=MyButton.h
ImplementationFile=MyButton.cpp
BaseClass=CButton
Filter=W
VirtualFilter=BWC
LastObject=CMyButton

[CLS:CStaticDisplay]
Type=0
HeaderFile=StaticDisplay.h
ImplementationFile=StaticDisplay.cpp
BaseClass=CStatic
Filter=W
VirtualFilter=WC
LastObject=CStaticDisplay

