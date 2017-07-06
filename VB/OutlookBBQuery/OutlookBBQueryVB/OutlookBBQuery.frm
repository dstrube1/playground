VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   7665
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9135
   LinkTopic       =   "Form1"
   ScaleHeight     =   7665
   ScaleWidth      =   9135
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   7215
      Left            =   1440
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   2
      Top             =   0
      Width           =   6255
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Go"
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   2640
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   975
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    Dim outlookApp As Object
    Set outlookApp = CreateObject("Outlook.Application")
     Set olNameSpace = outlookApp.GetNameSpace("MAPI")
     Set oFolder = olNameSpace.Folders("Public Folders")
    Set oFolder = oFolder.Folders("All Public Folders")
    Set oFolder = oFolder.Folders("Department")
    Set oFolder = oFolder.Folders("Marketing and PR")
    Set oFolder = oFolder.Folders("Bulletin Board")
    Set oFolder = oFolder.Folders("BB Passwords") ' oFolder.DefaultMessageClass = IPM.Contact
    ' Text1.Text = oFolder.Items.Count & vbCrLf = 379
    ' Item.MessageClass = IPM.Contact || IPM.Contact.Bulletin Board Member
    For Each Item In oFolder.Items
        If Item.MessageClass = "IPM.Contact.Bulletin Board Member" Then
            Text1.Text = Text1.Text & vbCrLf & Item.CompanyName
            If Item.CompanyName = "Cooper Pediatrics" Then
                'Item.MessageClass = "IPM.Contact.Contact Item"
                'Item.Save
            End If
        Else
            If Item.CompanyName = "Cooper Pediatrics" Then
                Item.MessageClass = "IPM.Contact.Bulletin Board Member"
                Item.Save
                'Text1.Text = Text1.Text & vbCrLf & "FOUND CARRAWAY!!!!!!!!!!!"
            End If
'            If Item.MessageClass = "IPM.Contact" Then
'                Text1.Text = Text1.Text & vbCrLf & Item.MessageClass & "; " & Item.CompanyName
'                Item.MessageClass = "IPM.Contact.Bulletin Board Member"
'                Item.Save
'            Else
'                Text1.Text = Text1.Text & vbCrLf & Item.MessageClass & " not BBM and not found"
'            End If
        End If
   'Try
    'risk goes here
   'Catch ex As Exception
    'Exit For
    'Do nothing if thats an option
  'End Try
        ' " = " &
        'Item.Class
        'Item.UserProperties("ID No.") ' throws error at some point
        'Item.CompanyName
        'vbNewLine vbCr chr(10)&chr(13)
    Next
    olNameSpace.logoff
    'olNameSpace = Nothing
    'oFolder = Nothing
    'outlookApp = Nothing
End Sub

Private Sub Form_Resize()
    Text1.Width = Form1.Width - 2000
    Text1.Height = Form1.Height - 1000
End Sub

