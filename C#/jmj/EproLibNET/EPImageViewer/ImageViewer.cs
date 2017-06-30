using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Threading;
using Atalasoft.Imaging.Drawing;
using Atalasoft.Imaging;
using Atalasoft.Imaging.ImageProcessing;
using Atalasoft.Imaging.ImageProcessing.Document;

namespace EPImageViewer
{

	enum DrawMenuMode
	{
		None      = 0,
		Line      = 1,
		Lines     = 2,
		Ellipse   = 3,
		Rectangle = 4,
		FloodFill = 5,
		Freehand  = 6,
		Polygon   = 7,
		Text      = 8
	}

	/// <summary>
	/// Summary description for ImageViewer.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDual)]
	internal class ImageViewer : System.Windows.Forms.Form
	{
		private const int maxUndrawn = 5;
		private int undrawn = 0;
		private System.Collections.ArrayList points = new ArrayList();
		private DrawMenuMode drawMode = DrawMenuMode.None;

		private bool editMode=false;
		private bool edited=false;
		private bool readOnly=true;
		private string fileName=null;
		private int currentPage=0;
		private int pageCount=0;
		private Atalasoft.Imaging.ProgressEventHandler peh;
		private Atalasoft.Imaging.ImageProcessing.Transforms.RotateCommand RotateLeft = new Atalasoft.Imaging.ImageProcessing.Transforms.RotateCommand(-90.0D);
		private Atalasoft.Imaging.ImageProcessing.Transforms.RotateCommand RotateRight = new Atalasoft.Imaging.ImageProcessing.Transforms.RotateCommand(90.0D);

		private Point clickPos;
		private System.Windows.Forms.ToolBar toolBar1;
		private System.Windows.Forms.ToolBarButton bPageUp;
		private System.Windows.Forms.ToolBarButton bSelectPage;
		private System.Windows.Forms.ToolBarButton bPageDown;
		private System.Windows.Forms.ToolBarButton bSeparator1;
		private System.Windows.Forms.ToolBarButton bRotateLeft;
		private System.Windows.Forms.ToolBarButton bRotateRight;
		private System.Windows.Forms.ToolBarButton bSeparator2;
		private System.Windows.Forms.ToolBarButton bFitWidth;
		private System.Windows.Forms.ToolBarButton bFitPage;
		private System.Windows.Forms.ToolBarButton bSeparator3;
		private System.Windows.Forms.ToolBarButton bActualSize;
		private System.Windows.Forms.ToolBarButton bZoomMinus;
		private System.Windows.Forms.ToolBarButton bZoomPlus;
		private System.Windows.Forms.ToolBarButton bSeparator4;
		private System.Windows.Forms.ToolBarButton bPrint;
		private System.Windows.Forms.ImageList imageList1;
		private System.Windows.Forms.ContextMenu mPageMenu;
		private System.Windows.Forms.ToolBarButton bSeparator5;
		private System.Windows.Forms.ToolBarButton bExit;
		private System.ComponentModel.IContainer components;
		private Atalasoft.Imaging.WinControls.ImagePrintDocument imagePrintDocument1;
		private Atalasoft.Imaging.WinControls.WorkspaceViewer imgViewControl;
		private System.Windows.Forms.PrintDialog printDialog1;
		private System.Windows.Forms.ToolBarButton bAntiAliasing;
		private System.Windows.Forms.ToolBarButton bSeparator6;
		private System.Windows.Forms.ContextMenu mMouseToolMenu;
		private System.Windows.Forms.MenuItem miMTNone;
		private System.Windows.Forms.MenuItem miMTMagnifier;
		private System.Windows.Forms.MenuItem miMTZoomIn;
		private System.Windows.Forms.MenuItem miMTZoomOut;
		private System.Windows.Forms.MenuItem miMTPan;
		private System.Windows.Forms.MenuItem miMTZoomArea;
		private System.Windows.Forms.ToolBarButton bMouseTool;
		private System.Windows.Forms.ImageList imageList2;
		private Atalasoft.Imaging.WinControls.EllipseRubberband ellipseRubberband1;
		private Atalasoft.Imaging.WinControls.LineRubberband lineRubberband1;
		private Atalasoft.Imaging.WinControls.RectangleRubberband rectangleRubberband1;
		private System.Windows.Forms.FontDialog fontDialog1;
		private System.Windows.Forms.ColorDialog colorDialog1;
		private System.Windows.Forms.Panel pSidePanel;
		private System.Windows.Forms.Button bColor;
		private System.Windows.Forms.ToolTip tips;
		private System.Windows.Forms.MenuItem miMTEditMode;
		private System.Windows.Forms.Button bPen;
		private System.Windows.Forms.Button bText;
		private System.Windows.Forms.Button bUndo;
		private System.Windows.Forms.Button bRedo;
		private System.Windows.Forms.Panel pFillPanel;
		private System.Windows.Forms.Panel versionPanel;
		private System.Windows.Forms.PrintPreviewDialog printPreviewDialog1;
		private System.Windows.Forms.ContextMenu mPrintMenu;
		private System.Windows.Forms.MenuItem miPrint;
		private System.Windows.Forms.MenuItem miPrintPreview;
		private System.Windows.Forms.MenuItem miIgnoreMargins;
		private System.Windows.Forms.PageSetupDialog pageSetupDialog1;
		private System.Windows.Forms.MenuItem miPageSetup;

		private Utilities util=null;

		public bool EditMode
		{
			get
			{
				return editMode;
			}
			set
			{
				editMode=value;
				if(editMode)
					pSidePanel.Visible=true;
				else
					pSidePanel.Visible=false;
			}
		}

		public ImageViewer()
		{
			InitializeComponent();
			util=new Utilities();
			util.InitializeEventLog("EPImageViewer");
			peh = new Atalasoft.Imaging.ProgressEventHandler(AtalaProgress);
			imgViewControl.MouseWheel+=new MouseEventHandler(imgViewControl_MouseWheel);
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(ImageViewer));
			this.toolBar1 = new System.Windows.Forms.ToolBar();
			this.bPageUp = new System.Windows.Forms.ToolBarButton();
			this.bSelectPage = new System.Windows.Forms.ToolBarButton();
			this.mPageMenu = new System.Windows.Forms.ContextMenu();
			this.bPageDown = new System.Windows.Forms.ToolBarButton();
			this.bSeparator1 = new System.Windows.Forms.ToolBarButton();
			this.bRotateLeft = new System.Windows.Forms.ToolBarButton();
			this.bRotateRight = new System.Windows.Forms.ToolBarButton();
			this.bSeparator2 = new System.Windows.Forms.ToolBarButton();
			this.bActualSize = new System.Windows.Forms.ToolBarButton();
			this.bFitWidth = new System.Windows.Forms.ToolBarButton();
			this.bFitPage = new System.Windows.Forms.ToolBarButton();
			this.bSeparator3 = new System.Windows.Forms.ToolBarButton();
			this.bZoomMinus = new System.Windows.Forms.ToolBarButton();
			this.bZoomPlus = new System.Windows.Forms.ToolBarButton();
			this.bSeparator4 = new System.Windows.Forms.ToolBarButton();
			this.bPrint = new System.Windows.Forms.ToolBarButton();
			this.bSeparator5 = new System.Windows.Forms.ToolBarButton();
			this.bAntiAliasing = new System.Windows.Forms.ToolBarButton();
			this.bMouseTool = new System.Windows.Forms.ToolBarButton();
			this.mMouseToolMenu = new System.Windows.Forms.ContextMenu();
			this.miMTNone = new System.Windows.Forms.MenuItem();
			this.miMTPan = new System.Windows.Forms.MenuItem();
			this.miMTMagnifier = new System.Windows.Forms.MenuItem();
			this.miMTZoomIn = new System.Windows.Forms.MenuItem();
			this.miMTZoomOut = new System.Windows.Forms.MenuItem();
			this.miMTZoomArea = new System.Windows.Forms.MenuItem();
			this.miMTEditMode = new System.Windows.Forms.MenuItem();
			this.bSeparator6 = new System.Windows.Forms.ToolBarButton();
			this.bExit = new System.Windows.Forms.ToolBarButton();
			this.imageList1 = new System.Windows.Forms.ImageList(this.components);
			this.imagePrintDocument1 = new Atalasoft.Imaging.WinControls.ImagePrintDocument();
			this.imgViewControl = new Atalasoft.Imaging.WinControls.WorkspaceViewer();
			this.printDialog1 = new System.Windows.Forms.PrintDialog();
			this.imageList2 = new System.Windows.Forms.ImageList(this.components);
			this.ellipseRubberband1 = new Atalasoft.Imaging.WinControls.EllipseRubberband();
			this.lineRubberband1 = new Atalasoft.Imaging.WinControls.LineRubberband();
			this.rectangleRubberband1 = new Atalasoft.Imaging.WinControls.RectangleRubberband();
			this.fontDialog1 = new System.Windows.Forms.FontDialog();
			this.colorDialog1 = new System.Windows.Forms.ColorDialog();
			this.pSidePanel = new System.Windows.Forms.Panel();
			this.bRedo = new System.Windows.Forms.Button();
			this.bUndo = new System.Windows.Forms.Button();
			this.bText = new System.Windows.Forms.Button();
			this.bPen = new System.Windows.Forms.Button();
			this.bColor = new System.Windows.Forms.Button();
			this.versionPanel = new System.Windows.Forms.Panel();
			this.tips = new System.Windows.Forms.ToolTip(this.components);
			this.pFillPanel = new System.Windows.Forms.Panel();
			this.printPreviewDialog1 = new System.Windows.Forms.PrintPreviewDialog();
			this.mPrintMenu = new System.Windows.Forms.ContextMenu();
			this.miPrint = new System.Windows.Forms.MenuItem();
			this.miPrintPreview = new System.Windows.Forms.MenuItem();
			this.miIgnoreMargins = new System.Windows.Forms.MenuItem();
			this.miPageSetup = new System.Windows.Forms.MenuItem();
			this.pageSetupDialog1 = new System.Windows.Forms.PageSetupDialog();
			this.pSidePanel.SuspendLayout();
			this.pFillPanel.SuspendLayout();
			this.SuspendLayout();
			// 
			// toolBar1
			// 
			this.toolBar1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.toolBar1.Buttons.AddRange(new System.Windows.Forms.ToolBarButton[] {
																						this.bPageUp,
																						this.bSelectPage,
																						this.bPageDown,
																						this.bSeparator1,
																						this.bRotateLeft,
																						this.bRotateRight,
																						this.bSeparator2,
																						this.bActualSize,
																						this.bFitWidth,
																						this.bFitPage,
																						this.bSeparator3,
																						this.bZoomMinus,
																						this.bZoomPlus,
																						this.bSeparator4,
																						this.bPrint,
																						this.bSeparator5,
																						this.bAntiAliasing,
																						this.bMouseTool,
																						this.bSeparator6,
																						this.bExit});
			this.toolBar1.Divider = false;
			this.toolBar1.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.toolBar1.DropDownArrows = true;
			this.toolBar1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.toolBar1.ImageList = this.imageList1;
			this.toolBar1.Location = new System.Drawing.Point(0, 323);
			this.toolBar1.Name = "toolBar1";
			this.toolBar1.ShowToolTips = true;
			this.toolBar1.Size = new System.Drawing.Size(608, 43);
			this.toolBar1.TabIndex = 1;
			this.toolBar1.TextAlign = System.Windows.Forms.ToolBarTextAlign.Right;
			this.toolBar1.Wrappable = false;
			this.toolBar1.Resize += new System.EventHandler(this.toolBar1_Resize);
			this.toolBar1.ButtonClick += new System.Windows.Forms.ToolBarButtonClickEventHandler(this.toolBar1_ButtonClick);
			this.toolBar1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.toolBar1_MouseDown);
			// 
			// bPageUp
			// 
			this.bPageUp.ImageIndex = 0;
			this.bPageUp.ToolTipText = "Previous Page";
			// 
			// bSelectPage
			// 
			this.bSelectPage.DropDownMenu = this.mPageMenu;
			this.bSelectPage.ImageIndex = 1;
			this.bSelectPage.ToolTipText = "Select Page";
			// 
			// bPageDown
			// 
			this.bPageDown.ImageIndex = 2;
			this.bPageDown.ToolTipText = "Next Page";
			// 
			// bSeparator1
			// 
			this.bSeparator1.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
			// 
			// bRotateLeft
			// 
			this.bRotateLeft.ImageIndex = 3;
			this.bRotateLeft.ToolTipText = "Rotate 90° Left";
			// 
			// bRotateRight
			// 
			this.bRotateRight.ImageIndex = 4;
			this.bRotateRight.ToolTipText = "Rotate 90° Right";
			// 
			// bSeparator2
			// 
			this.bSeparator2.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
			// 
			// bActualSize
			// 
			this.bActualSize.ImageIndex = 5;
			this.bActualSize.ToolTipText = "Zoom 100%";
			// 
			// bFitWidth
			// 
			this.bFitWidth.ImageIndex = 6;
			this.bFitWidth.ToolTipText = "Fit to Window Width";
			// 
			// bFitPage
			// 
			this.bFitPage.ImageIndex = 7;
			this.bFitPage.ToolTipText = "Best Fit";
			// 
			// bSeparator3
			// 
			this.bSeparator3.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
			// 
			// bZoomMinus
			// 
			this.bZoomMinus.ImageIndex = 8;
			this.bZoomMinus.ToolTipText = "Zoom Out";
			// 
			// bZoomPlus
			// 
			this.bZoomPlus.ImageIndex = 9;
			this.bZoomPlus.ToolTipText = "Zoom In";
			// 
			// bSeparator4
			// 
			this.bSeparator4.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
			// 
			// bPrint
			// 
			this.bPrint.ImageIndex = 10;
			this.bPrint.ToolTipText = "Print...";
			// 
			// bSeparator5
			// 
			this.bSeparator5.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
			// 
			// bAntiAliasing
			// 
			this.bAntiAliasing.ImageIndex = 11;
			this.bAntiAliasing.Style = System.Windows.Forms.ToolBarButtonStyle.ToggleButton;
			this.bAntiAliasing.ToolTipText = "Antialiasing";
			// 
			// bMouseTool
			// 
			this.bMouseTool.DropDownMenu = this.mMouseToolMenu;
			this.bMouseTool.ImageIndex = 13;
			this.bMouseTool.ToolTipText = "Mouse Tool";
			// 
			// mMouseToolMenu
			// 
			this.mMouseToolMenu.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																						   this.miMTNone,
																						   this.miMTPan,
																						   this.miMTMagnifier,
																						   this.miMTZoomIn,
																						   this.miMTZoomOut,
																						   this.miMTZoomArea,
																						   this.miMTEditMode});
			// 
			// miMTNone
			// 
			this.miMTNone.Index = 0;
			this.miMTNone.OwnerDraw = true;
			this.miMTNone.Text = "None";
			this.miMTNone.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miMTNone.Click += new System.EventHandler(this.miMTNone_Click);
			this.miMTNone.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miMTPan
			// 
			this.miMTPan.Index = 1;
			this.miMTPan.OwnerDraw = true;
			this.miMTPan.Text = "Pan";
			this.miMTPan.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miMTPan.Click += new System.EventHandler(this.miMTPan_Click);
			this.miMTPan.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miMTMagnifier
			// 
			this.miMTMagnifier.Index = 2;
			this.miMTMagnifier.OwnerDraw = true;
			this.miMTMagnifier.Text = "Magnifier";
			this.miMTMagnifier.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miMTMagnifier.Click += new System.EventHandler(this.miMTMagnifier_Click);
			this.miMTMagnifier.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miMTZoomIn
			// 
			this.miMTZoomIn.Index = 3;
			this.miMTZoomIn.OwnerDraw = true;
			this.miMTZoomIn.Text = "Zoom In";
			this.miMTZoomIn.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miMTZoomIn.Click += new System.EventHandler(this.miMTZoomIn_Click);
			this.miMTZoomIn.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miMTZoomOut
			// 
			this.miMTZoomOut.Index = 4;
			this.miMTZoomOut.OwnerDraw = true;
			this.miMTZoomOut.Text = "Zoom Out";
			this.miMTZoomOut.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miMTZoomOut.Click += new System.EventHandler(this.miMTZoomOut_Click);
			this.miMTZoomOut.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miMTZoomArea
			// 
			this.miMTZoomArea.Index = 5;
			this.miMTZoomArea.OwnerDraw = true;
			this.miMTZoomArea.Text = "Zoom Area";
			this.miMTZoomArea.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miMTZoomArea.Click += new System.EventHandler(this.miMTZoomArea_Click);
			this.miMTZoomArea.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miMTEditMode
			// 
			this.miMTEditMode.Index = 6;
			this.miMTEditMode.OwnerDraw = true;
			this.miMTEditMode.Text = "Edit Mode";
			this.miMTEditMode.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miMTEditMode.Click += new System.EventHandler(this.miMTEditMode_Click);
			this.miMTEditMode.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// bSeparator6
			// 
			this.bSeparator6.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
			// 
			// bExit
			// 
			this.bExit.ImageIndex = 12;
			this.bExit.ToolTipText = "Close Image";
			// 
			// imageList1
			// 
			this.imageList1.ImageSize = new System.Drawing.Size(32, 32);
			this.imageList1.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList1.ImageStream")));
			this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
			// 
			// imagePrintDocument1
			// 
			this.imagePrintDocument1.Images = new Atalasoft.Imaging.AtalaImage[0];
			this.imagePrintDocument1.ScaleMode = Atalasoft.Imaging.WinControls.PrintScaleMode.FitToEdges;
			this.imagePrintDocument1.PrintImage += new Atalasoft.Imaging.WinControls.PrintImageEventHandler(this.imagePrintDocument1_PrintImage);
			this.imagePrintDocument1.GetImage += new Atalasoft.Imaging.WinControls.PrintImageEventHandler(this.imagePrintDocument1_GetImage);
			// 
			// imgViewControl
			// 
			this.imgViewControl.BackColor = System.Drawing.SystemColors.Control;
			this.imgViewControl.Centered = true;
			this.imgViewControl.DisplayProfile = null;
			this.imgViewControl.Dock = System.Windows.Forms.DockStyle.Fill;
			this.imgViewControl.Location = new System.Drawing.Point(0, 0);
			this.imgViewControl.Magnifier.BackColor = System.Drawing.SystemColors.Control;
			this.imgViewControl.Magnifier.BorderColor = System.Drawing.Color.Black;
			this.imgViewControl.Magnifier.Size = new System.Drawing.Size(400, 200);
			this.imgViewControl.Magnifier.Zoom = 1;
			this.imgViewControl.Name = "imgViewControl";
			this.imgViewControl.OutputProfile = null;
			this.imgViewControl.ScrollPosition = new System.Drawing.Point(304, 161);
			this.imgViewControl.ScrollSize = new System.Drawing.Size(0, 0);
			this.imgViewControl.Selection = null;
			this.imgViewControl.Size = new System.Drawing.Size(608, 323);
			this.imgViewControl.TabIndex = 0;
			this.imgViewControl.UndoLevels = 10;
			this.imgViewControl.ZoomInOutPercentage = 25;
			this.imgViewControl.MouseMovePixel += new System.Windows.Forms.MouseEventHandler(this.imgViewControl_MouseMovePixel);
			this.imgViewControl.MouseDown += new System.Windows.Forms.MouseEventHandler(this.imgViewControl_MouseDown);
			this.imgViewControl.MouseUp += new System.Windows.Forms.MouseEventHandler(this.imgViewControl_MouseUp);
			this.imgViewControl.ZoomChanged += new System.EventHandler(this.imgViewControl_ZoomChanged);
			// 
			// printDialog1
			// 
			this.printDialog1.AllowSelection = true;
			this.printDialog1.AllowSomePages = true;
			this.printDialog1.Document = this.imagePrintDocument1;
			// 
			// imageList2
			// 
			this.imageList2.ImageSize = new System.Drawing.Size(16, 16);
			this.imageList2.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList2.ImageStream")));
			this.imageList2.TransparentColor = System.Drawing.Color.Transparent;
			// 
			// ellipseRubberband1
			// 
			this.ellipseRubberband1.ActiveButtons = System.Windows.Forms.MouseButtons.Left;
			this.ellipseRubberband1.AspectRatio = 0F;
			this.ellipseRubberband1.BackgroundColor = System.Drawing.Color.Transparent;
			this.ellipseRubberband1.ConstrainPosition = false;
			this.ellipseRubberband1.Fill = null;
			this.ellipseRubberband1.MoveCursor = System.Windows.Forms.Cursors.SizeAll;
			this.ellipseRubberband1.Parent = this.imgViewControl;
			this.ellipseRubberband1.Pen.Color = System.Drawing.Color.Black;
			this.ellipseRubberband1.Pen.CustomDashPattern = new int[] {
																		  8,
																		  8};
			this.ellipseRubberband1.Persist = true;
			this.ellipseRubberband1.SnapToPixelGrid = false;
			// 
			// lineRubberband1
			// 
			this.lineRubberband1.ActiveButtons = System.Windows.Forms.MouseButtons.Left;
			this.lineRubberband1.AspectRatio = 0F;
			this.lineRubberband1.BackgroundColor = System.Drawing.Color.Transparent;
			this.lineRubberband1.MoveCursor = System.Windows.Forms.Cursors.SizeAll;
			this.lineRubberband1.Parent = this.imgViewControl;
			this.lineRubberband1.Pen.Color = System.Drawing.Color.Black;
			this.lineRubberband1.Pen.CustomDashPattern = new int[] {
																	   8,
																	   8};
			// 
			// rectangleRubberband1
			// 
			this.rectangleRubberband1.ActiveButtons = System.Windows.Forms.MouseButtons.Left;
			this.rectangleRubberband1.AspectRatio = 0F;
			this.rectangleRubberband1.BackgroundColor = System.Drawing.Color.Transparent;
			this.rectangleRubberband1.CornerRadius = new System.Drawing.Size(0, 0);
			this.rectangleRubberband1.Fill = null;
			this.rectangleRubberband1.MoveCursor = System.Windows.Forms.Cursors.SizeAll;
			this.rectangleRubberband1.Parent = this.imgViewControl;
			this.rectangleRubberband1.Pen.Color = System.Drawing.Color.Black;
			this.rectangleRubberband1.Pen.CustomDashPattern = new int[] {
																			8,
																			8};
			// 
			// colorDialog1
			// 
			this.colorDialog1.AnyColor = true;
			// 
			// pSidePanel
			// 
			this.pSidePanel.Controls.Add(this.bRedo);
			this.pSidePanel.Controls.Add(this.bUndo);
			this.pSidePanel.Controls.Add(this.bText);
			this.pSidePanel.Controls.Add(this.bPen);
			this.pSidePanel.Controls.Add(this.bColor);
			this.pSidePanel.Controls.Add(this.versionPanel);
			this.pSidePanel.Dock = System.Windows.Forms.DockStyle.Left;
			this.pSidePanel.Location = new System.Drawing.Point(0, 0);
			this.pSidePanel.Name = "pSidePanel";
			this.pSidePanel.Size = new System.Drawing.Size(24, 366);
			this.pSidePanel.TabIndex = 0;
			this.pSidePanel.Visible = false;
			// 
			// bRedo
			// 
			this.bRedo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.bRedo.ImageIndex = 3;
			this.bRedo.ImageList = this.imageList2;
			this.bRedo.Location = new System.Drawing.Point(0, 200);
			this.bRedo.Name = "bRedo";
			this.bRedo.Size = new System.Drawing.Size(24, 24);
			this.bRedo.TabIndex = 4;
			this.bRedo.Click += new System.EventHandler(this.bRedo_Click);
			// 
			// bUndo
			// 
			this.bUndo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.bUndo.ImageIndex = 2;
			this.bUndo.ImageList = this.imageList2;
			this.bUndo.Location = new System.Drawing.Point(0, 176);
			this.bUndo.Name = "bUndo";
			this.bUndo.Size = new System.Drawing.Size(24, 24);
			this.bUndo.TabIndex = 3;
			this.bUndo.Click += new System.EventHandler(this.bUndo_Click);
			// 
			// bText
			// 
			this.bText.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.bText.ImageIndex = 1;
			this.bText.ImageList = this.imageList2;
			this.bText.Location = new System.Drawing.Point(0, 64);
			this.bText.Name = "bText";
			this.bText.Size = new System.Drawing.Size(24, 24);
			this.bText.TabIndex = 2;
			this.bText.Click += new System.EventHandler(this.bText_Click);
			// 
			// bPen
			// 
			this.bPen.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.bPen.ImageIndex = 0;
			this.bPen.ImageList = this.imageList2;
			this.bPen.Location = new System.Drawing.Point(0, 40);
			this.bPen.Name = "bPen";
			this.bPen.Size = new System.Drawing.Size(24, 24);
			this.bPen.TabIndex = 1;
			this.bPen.Click += new System.EventHandler(this.bPen_Click);
			// 
			// bColor
			// 
			this.bColor.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.bColor.Location = new System.Drawing.Point(0, 8);
			this.bColor.Name = "bColor";
			this.bColor.Size = new System.Drawing.Size(24, 24);
			this.bColor.TabIndex = 0;
			this.bColor.Click += new System.EventHandler(this.bColor_Click);
			// 
			// versionPanel
			// 
			this.versionPanel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.versionPanel.Location = new System.Drawing.Point(0, 248);
			this.versionPanel.Name = "versionPanel";
			this.versionPanel.Size = new System.Drawing.Size(16, 120);
			this.versionPanel.TabIndex = 2;
			this.versionPanel.Paint += new System.Windows.Forms.PaintEventHandler(this.versionPanel_Paint);
			// 
			// pFillPanel
			// 
			this.pFillPanel.Controls.Add(this.imgViewControl);
			this.pFillPanel.Controls.Add(this.toolBar1);
			this.pFillPanel.Dock = System.Windows.Forms.DockStyle.Fill;
			this.pFillPanel.Location = new System.Drawing.Point(24, 0);
			this.pFillPanel.Name = "pFillPanel";
			this.pFillPanel.Size = new System.Drawing.Size(608, 366);
			this.pFillPanel.TabIndex = 5;
			// 
			// printPreviewDialog1
			// 
			this.printPreviewDialog1.AutoScrollMargin = new System.Drawing.Size(0, 0);
			this.printPreviewDialog1.AutoScrollMinSize = new System.Drawing.Size(0, 0);
			this.printPreviewDialog1.ClientSize = new System.Drawing.Size(400, 300);
			this.printPreviewDialog1.Document = this.imagePrintDocument1;
			this.printPreviewDialog1.Enabled = true;
			this.printPreviewDialog1.Icon = ((System.Drawing.Icon)(resources.GetObject("printPreviewDialog1.Icon")));
			this.printPreviewDialog1.Location = new System.Drawing.Point(19, 86);
			this.printPreviewDialog1.MinimumSize = new System.Drawing.Size(375, 250);
			this.printPreviewDialog1.Name = "printPreviewDialog1";
			this.printPreviewDialog1.TransparencyKey = System.Drawing.Color.Empty;
			this.printPreviewDialog1.Visible = false;
			// 
			// mPrintMenu
			// 
			this.mPrintMenu.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					   this.miPrint,
																					   this.miPrintPreview,
																					   this.miIgnoreMargins,
																					   this.miPageSetup});
			// 
			// miPrint
			// 
			this.miPrint.DefaultItem = true;
			this.miPrint.Index = 0;
			this.miPrint.OwnerDraw = true;
			this.miPrint.Text = "&Print...";
			this.miPrint.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miPrint.Click += new System.EventHandler(this.miPrint_Click);
			this.miPrint.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miPrintPreview
			// 
			this.miPrintPreview.Index = 1;
			this.miPrintPreview.OwnerDraw = true;
			this.miPrintPreview.Text = "Print Pre&view...";
			this.miPrintPreview.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miPrintPreview.Click += new System.EventHandler(this.miPrintPreview_Click);
			this.miPrintPreview.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miIgnoreMargins
			// 
			this.miIgnoreMargins.Checked = true;
			this.miIgnoreMargins.Index = 2;
			this.miIgnoreMargins.OwnerDraw = true;
			this.miIgnoreMargins.Text = "Ignore Margins";
			this.miIgnoreMargins.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miIgnoreMargins.Click += new System.EventHandler(this.miIgnoreMargins_Click);
			this.miIgnoreMargins.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// miPageSetup
			// 
			this.miPageSetup.Index = 3;
			this.miPageSetup.OwnerDraw = true;
			this.miPageSetup.Text = "Page Setup...";
			this.miPageSetup.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.miItem_DrawItem);
			this.miPageSetup.Click += new System.EventHandler(this.miPageSetup_Click);
			this.miPageSetup.MeasureItem += new System.Windows.Forms.MeasureItemEventHandler(this.miItem_MeasureItem);
			// 
			// pageSetupDialog1
			// 
			this.pageSetupDialog1.Document = this.imagePrintDocument1;
			// 
			// ImageViewer
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(632, 366);
			this.Controls.Add(this.pFillPanel);
			this.Controls.Add(this.pSidePanel);
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.MinimumSize = new System.Drawing.Size(100, 100);
			this.Name = "ImageViewer";
			this.Text = "ImageViewer";
			this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
			this.Resize += new System.EventHandler(this.ImageViewer_Resize);
			this.MouseDown += new System.Windows.Forms.MouseEventHandler(this.ImageViewer_MouseDown);
			this.Closing += new System.ComponentModel.CancelEventHandler(this.ImageViewer_Closing);
			this.Load += new System.EventHandler(this.ImageViewer_Load);
			this.pSidePanel.ResumeLayout(false);
			this.pFillPanel.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		public int LoadImageFromFile(string FileName, bool ReadOnly)
		{
			fileName=FileName;
			readOnly=ReadOnly;
			try
			{
				this.Text = System.IO.Path.GetFileName(fileName);
				if(readOnly)
					this.Text+= " (Read-Only)";

				imgViewControl.Open(fileName);
				pageCount=imgViewControl.Images.Count;
				
				for(int i=0; i<pageCount; i++)
				{
					imgViewControl.Images[i] = FixResolution(imgViewControl.Images[i]);
				}

				mPageMenu.MenuItems.Clear();
				for(int i=0; i<pageCount; i++)
				{
					MenuItem nmi = new MenuItem("Page " + ((int)i+1).ToString(), new EventHandler(mPageMenuItem_Click));
					nmi.OwnerDraw=true;
					nmi.DrawItem+=new DrawItemEventHandler(miItem_DrawItem);
					nmi.MeasureItem+=new MeasureItemEventHandler(miItem_MeasureItem);
					mPageMenu.MenuItems.Add(i,nmi);
				}

				FixButtons();
				return 1;
			}
			catch(Exception exc)
			{
				util.LogEvent(exc.Source,exc.TargetSite.Name,"Error Loading Image in file "+fileName+"\r\n\r\n"+exc.ToString(),4);
				return -1;
			}
			finally
			{
				Activate();
				BringToFront();
			}
		}

		private void mPageMenuItem_Click(object sender, System.EventArgs e)
		{
			currentPage=((MenuItem)sender).Index;
			imgViewControl.Images.Current=imgViewControl.Images[currentPage];
			FixButtons();
		}


		private void toolBar1_Resize(object sender, System.EventArgs e)
		{
			try
			{
				imgViewControl.Height=(this.ClientSize.Height-toolBar1.Height);
			}
			catch{}
		}

		private void toolBar1_ButtonClick(object sender, System.Windows.Forms.ToolBarButtonClickEventArgs e)
		{
			if(null==imgViewControl.Images)
			{
				return;
			}
			if (e.Button.Equals(bPageUp))
			{
				currentPage--;
				imgViewControl.Images.MovePrevious();
				FixButtons();
			}
			else if (e.Button.Equals(bSelectPage))
			{
				mPageMenu.Show(toolBar1,clickPos);
			}
			else if (e.Button.Equals(bPageDown))
			{
				currentPage++;
				imgViewControl.Images.MoveNext();
				FixButtons();
			}
			else if (e.Button.Equals(bMouseTool))
			{
				mMouseToolMenu.Show(toolBar1,clickPos);
			}
			else if (e.Button.Equals(bAntiAliasing))
			{
				if(imgViewControl.AntialiasDisplay==Atalasoft.Imaging.WinControls.AntialiasDisplayMode.None)
				{
					imgViewControl.AntialiasDisplay=Atalasoft.Imaging.WinControls.AntialiasDisplayMode.Full;
				}
				else
				{
					imgViewControl.AntialiasDisplay=Atalasoft.Imaging.WinControls.AntialiasDisplayMode.None;
				}
			}
			else if (e.Button.Equals(bRotateLeft))
			{
				imgViewControl.ApplyCommand(RotateLeft);
			}
			else if (e.Button.Equals(bRotateRight))
			{
				imgViewControl.ApplyCommand(RotateRight);
			}
			else if (e.Button.Equals(bActualSize))
			{
				imgViewControl.Zoom=1.0D;
				FixButtons();
			}
			else if (e.Button.Equals(bFitWidth))
			{
				imgViewControl.SetZoomMode(Atalasoft.Imaging.WinControls.AutoZoomMode.FitToWidth);
				FixButtons();
			}
			else if (e.Button.Equals(bFitPage))
			{
				imgViewControl.SetZoomMode(Atalasoft.Imaging.WinControls.AutoZoomMode.BestFitShrinkOnly);
				FixButtons();
			}
			else if (e.Button.Equals(bZoomMinus))
			{
				if(imgViewControl.Zoom>.05)
				{
					imgViewControl.Zoom*=(2.0/3.0);
				}
				FixButtons();
			}
			else if (e.Button.Equals(bZoomPlus))
			{
				if(imgViewControl.Zoom<15)
				{
					imgViewControl.Zoom*=1.5;
				}
			}
			else if (e.Button.Equals(bPrint))
			{
				mPrintMenu.Show(toolBar1,clickPos);
			}
			else if (e.Button.Equals(bExit))
			{
				Exit();
			}
		}

		private void Exit()
		{
			GC.Collect();
			Close();
		}

		private void FixButtons()
		{
			if(pageCount<=1)
			{
				bPageUp.Visible=false;
				bSelectPage.Visible=false;
				bPageDown.Visible=false;
				bSeparator1.Visible=false;
			}
			else
			{	
				bSelectPage.Text= (currentPage+1).ToString() + " of " + pageCount.ToString();
				foreach(MenuItem mItem in mPageMenu.MenuItems)
				{
					if(mItem.Index==currentPage)
					{
						mItem.Checked=true;
					}
					else
					{
						mItem.Checked=false;
					}
				}

				bPageUp.Visible=true;
				bSelectPage.Visible=true;
				bPageDown.Visible=true;
				bSeparator1.Visible=true;

				bPageUp.Enabled=true;
				bPageDown.Enabled=true;

				if(currentPage==0)
				{
					bPageUp.Enabled=false;
				}
				else if(currentPage==pageCount-1)
				{
					bPageDown.Enabled=false;
				}
			}
		}

		private void ImageViewer_MouseDown(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			clickPos = new Point(e.X,e.Y);
		}

		private void ImageViewer_Closing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			if(!readOnly && edited)
			{
				DialogResult dialogResult = MessageBox.Show(this,"Do you want to save changes to "+fileName+"?","Save Changes?",MessageBoxButtons.YesNoCancel,MessageBoxIcon.Question);
				switch(dialogResult)
				{
					case DialogResult.Yes:
						try
						{
							Atalasoft.Imaging.Codec.ImageEncoder enc = null;
							switch(System.IO.Path.GetExtension(fileName).ToLower())
							{
								case ".tif":
									if(imgViewControl.Image.PixelFormat == Atalasoft.Imaging.PixelFormat.Pixel1bppIndexed)
									{
										enc = new Atalasoft.Imaging.Codec.TiffEncoder(Atalasoft.Imaging.Codec.TiffCompression.Group4FaxEncoding);
									}
									else
									{
										enc = new Atalasoft.Imaging.Codec.TiffEncoder(Atalasoft.Imaging.Codec.TiffCompression.JpegCompression);
									}
									break;
								case ".wmf":
									enc = new Atalasoft.Imaging.Codec.WmfEncoder();
									break;
								case ".emf":
									enc = new Atalasoft.Imaging.Codec.EmfEncoder();
									break;
								case ".bmp":
									enc = new Atalasoft.Imaging.Codec.BmpEncoder(Atalasoft.Imaging.Codec.BmpCompression.None);
									break;
								case ".gif":
									enc = new Atalasoft.Imaging.Codec.GifEncoder(false,true);
									break;
								case ".png":
									enc = new Atalasoft.Imaging.Codec.PngEncoder();
									break;
								case ".psd":
									enc = new Atalasoft.Imaging.Codec.PsdEncoder();
									break;
								default:
									enc = new Atalasoft.Imaging.Codec.JpegEncoder(100);
									break;
							}
							imgViewControl.Save(fileName,enc);
						}
						catch(Exception exc)
						{
							MessageBox.Show(this,exc.Message,"Error saving file");
							e.Cancel=true;
							return;
						}
						break;
					case DialogResult.No:
						return;
					case DialogResult.Cancel:
						e.Cancel=true;
						return;
				}
			}
		}
		private void AtalaProgress(object sender, Atalasoft.Imaging.ProgressEventArgs e)
		{
		}

		private void ImageViewer_Load(object sender, System.EventArgs e)
		{
			imgViewControl.AntialiasDisplay=Atalasoft.Imaging.WinControls.AntialiasDisplayMode.None;
			if(null==imgViewControl.Images)
				return;
			imgViewControl.Update();
			imgViewControl.Images.Current=imgViewControl.Images[0];
			imgViewControl.SetZoomMode(Atalasoft.Imaging.WinControls.AutoZoomMode.FitToWidth);
			FixButtons();
			tips.SetToolTip(bColor,"Color");
			tips.SetToolTip(bPen,"Draw");
			tips.SetToolTip(bText,"Text");
			tips.SetToolTip(bUndo,"Undo");
			tips.SetToolTip(bRedo,"Redo");
			bColor.BackColor=colorDialog1.Color;
		}

		private void ImageViewer_Resize(object sender, System.EventArgs e)
		{
			if(imgViewControl.Size.Height==0)
			{
				imgViewControl.Size=new Size(1,1);
				toolBar1.Size=new Size(1,1);
			}
		}

		private void miMTNone_Click(object sender, System.EventArgs e)
		{
			imgViewControl.MouseTool=Atalasoft.Imaging.WinControls.MouseToolType.None;
			bMouseTool.ImageIndex=13;
			EditMode=false;
		}

		private void miMTPan_Click(object sender, System.EventArgs e)
		{
			imgViewControl.MouseTool=Atalasoft.Imaging.WinControls.MouseToolType.Pan;
			bMouseTool.ImageIndex=14;
			EditMode=false;
		}

		private void miMTMagnifier_Click(object sender, System.EventArgs e)
		{
			imgViewControl.MouseTool=Atalasoft.Imaging.WinControls.MouseToolType.Magnifier;
			bMouseTool.ImageIndex=15;
			EditMode=false;
		}

		private void miMTZoomIn_Click(object sender, System.EventArgs e)
		{
			imgViewControl.MouseTool=Atalasoft.Imaging.WinControls.MouseToolType.ZoomIn;
			bMouseTool.ImageIndex=16;
			EditMode=false;
		}

		private void miMTZoomOut_Click(object sender, System.EventArgs e)
		{
			imgViewControl.MouseTool=Atalasoft.Imaging.WinControls.MouseToolType.ZoomOut;
			bMouseTool.ImageIndex=17;
			EditMode=false;
		}

		private void miMTZoomArea_Click(object sender, System.EventArgs e)
		{
			imgViewControl.MouseTool=Atalasoft.Imaging.WinControls.MouseToolType.ZoomArea;
			bMouseTool.ImageIndex=18;
			EditMode=false;
		}

		private void toolBar1_MouseDown(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			clickPos = new Point(e.X,e.Y);
		}

		private void imgViewControl_ZoomChanged(object sender, System.EventArgs e)
		{
			imgViewControl.Magnifier.Zoom=imgViewControl.Zoom*2;
			if(imgViewControl.Magnifier.Zoom<.75)
				imgViewControl.Magnifier.Zoom=.75;
		}

		private void bColor_Click(object sender, System.EventArgs e)
		{
			if(colorDialog1.ShowDialog(this)==DialogResult.OK)
			{
				lineRubberband1.Pen.Color=colorDialog1.Color;
				ellipseRubberband1.Pen.Color=colorDialog1.Color;
				rectangleRubberband1.Pen.Color=colorDialog1.Color;
				bColor.BackColor=colorDialog1.Color;
			}
		}

		private void miMTEditMode_Click(object sender, System.EventArgs e)
		{
			imgViewControl.MouseTool=Atalasoft.Imaging.WinControls.MouseToolType.None;
			bMouseTool.ImageIndex=19;
			EditMode=true;
		}

		private void bPen_Click(object sender, System.EventArgs e)
		{
			drawMode = DrawMenuMode.Freehand;
		}

		private void bText_Click(object sender, System.EventArgs e)
		{
			drawMode = DrawMenuMode.Text;
		}

		private void imgViewControl_MouseDown(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			if(!EditMode)
				return;
			if (e.Button == MouseButtons.Left)
			{
				if (this.drawMode == DrawMenuMode.Freehand)
				{
					imgViewControl.Undos.Add("Freehand",true);
					points.Clear();
					points.Add(new Point((int)((e.X / imgViewControl.Zoom) - (imgViewControl.ImagePosition.X / imgViewControl.Zoom)), (int)((e.Y / imgViewControl.Zoom) - (imgViewControl.ImagePosition.Y / imgViewControl.Zoom))));
					undrawn=1;
					edited=true;
				}
				else if(this.drawMode ==DrawMenuMode.Text)
				{
					Atalasoft.Imaging.Drawing.Canvas myCanvas = new Atalasoft.Imaging.Drawing.Canvas(imgViewControl.Image);
					Atalasoft.Imaging.Drawing.AtalaPen myPen = new Atalasoft.Imaging.Drawing.AtalaPen(bColor.BackColor,3);
					Atalasoft.Imaging.Drawing.Fill myFill = new Atalasoft.Imaging.Drawing.SolidFill(bColor.BackColor);
					fText textForm = new fText();
					if(textForm.ShowDialog(this)==DialogResult.OK)
					{
						imgViewControl.Undos.Add("Text",true);
						myCanvas.DrawText(textForm.TextToDraw,new Point((int)((e.X / imgViewControl.Zoom) - (imgViewControl.ImagePosition.X / imgViewControl.Zoom)), (int)((e.Y / imgViewControl.Zoom) - (imgViewControl.ImagePosition.Y / imgViewControl.Zoom))),textForm.SelectedFont,myFill);
						edited=true;
						imgViewControl.Refresh();
					}
				}
			}
		}

		private void drawLines(Point[] points, System.IntPtr handle, System.Drawing.Pen pen)
		{
			System.Drawing.Graphics g = Graphics.FromHwnd(handle);
			//g.DrawLines(myPen, points);
			g.DrawLines(pen, points);
		}

		private Point[] ImgToControl(Point[] points)
		{
			for(int i=0; i<points.Length; i++)
			{
				points[i].X = (int) ((imgViewControl.Zoom * points[i].X) + (double) imgViewControl.ImagePosition.X);
				points[i].Y = (int) ((imgViewControl.Zoom * points[i].Y) + (double) imgViewControl.ImagePosition.Y);
			}
			return points;
		}

		private void imgViewControl_MouseMovePixel(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			if(!EditMode)
				return;
			if ((this.drawMode == DrawMenuMode.Freehand) && (e.Button == MouseButtons.Left))
			{
//				Canvas myCanvas = new Canvas(imgViewControl.Image);
//				myCanvas.DrawLine(this.polygonPoints[0], new Point(e.X, e.Y), this.lineRubberband1.Pen);
				points.Add(new Point(e.X, e.Y));
				undrawn++;
				//imgViewControl.Refresh();

				if (undrawn > maxUndrawn)
				{
					if (undrawn < points.Count)
						undrawn++;
					Point[] myPoints = new Point[undrawn];
					points.CopyTo(points.Count - undrawn, myPoints, 0, undrawn);
					myPoints = ImgToControl(myPoints);
					float penW = Math.Max(lineRubberband1.Pen.Width*(float)imgViewControl.Zoom,1f);
					System.Drawing.Pen myPen = new System.Drawing.Pen(lineRubberband1.Pen.Color, (float)penW);
					drawLines(myPoints, imgViewControl.Handle, myPen);
					undrawn = 0;
				}
			}
		}

		private void imgViewControl_MouseUp(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			if(!EditMode)
				return;
			if ((this.drawMode == DrawMenuMode.Freehand) && (e.Button == MouseButtons.Left))
			{
				Canvas myCanvas = new Canvas(imgViewControl.Image);
				Point[] myPoints = (Point[])points.ToArray(points[0].GetType());
				myCanvas.DrawLines(myPoints,this.lineRubberband1.Pen);
				points.Clear();
				undrawn = 0;
				imgViewControl.Refresh();
			}
		}

		private void imagePrintDocument1_GetImage(object sender, Atalasoft.Imaging.WinControls.PrintImageEventArgs e)
		{
			Atalasoft.Imaging.WinControls.ImagePrintDocument ipd = (Atalasoft.Imaging.WinControls.ImagePrintDocument)sender;

			int pageF=0, pageL=0;
			switch(ipd.PrinterSettings.PrintRange)
			{
				case System.Drawing.Printing.PrintRange.AllPages:
					pageF=0;
					pageL=pageCount-1;
					break;
				case System.Drawing.Printing.PrintRange.SomePages:
					pageF=ipd.PrinterSettings.FromPage-1;
					pageL=ipd.PrinterSettings.ToPage-1;
					break;
				case System.Drawing.Printing.PrintRange.Selection:
					pageF=currentPage;
					pageL=currentPage;
					break;
			}

			// Select the current image to print
			e.Image = imgViewControl.Images[e.ImageIndex+pageF];

						//tell the print controller to print more images (or not)
			if (e.ImageIndex + pageF >= pageL)
				e.HasMorePages = false;
			else
				e.HasMorePages = true;
		}

		private void InvalidateRegion(Point p1, Point p2, int LineWidth)
		{
			Rectangle rect = new Rectangle(p1,new Size(p2.X-p1.X,p2.Y-p1.Y));
			rect.Inflate(LineWidth,LineWidth);
			imgViewControl.Invalidate(rect);
		}

		private void bUndo_Click(object sender, System.EventArgs e)
		{
			imgViewControl.Undos.Undo();
		}

		private void bRedo_Click(object sender, System.EventArgs e)
		{
			imgViewControl.Undos.Redo();
		}

		private void imgViewControl_MouseWheel(object sender, MouseEventArgs e)
		{
			imgViewControl.ScrollPosition = new Point(imgViewControl.ScrollPosition.X, Math.Min(imgViewControl.ScrollPosition.Y + e.Delta,0));
		}

		private void versionPanel_Paint(object sender, System.Windows.Forms.PaintEventArgs e)
		{
			string version = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
			e.Graphics.DrawString(version, new Font(this.Font.FontFamily,8f),Brushes.Black,0,0,new StringFormat(StringFormatFlags.DirectionVertical));
		}

		private AtalaImage FixResolution(AtalaImage image)
		{
			if (image.Resolution.X != image.Resolution.Y)
			{
				// Correct the resolution and resize the image to match.
				float ratio = (float)image.Resolution.X / (float)image.Resolution.Y;
				image.Resolution = new Dpi(image.Resolution.X, image.Resolution.X, image.Resolution.Units);
  
				ImageCommand cmd = null;
				if (image.PixelFormat == PixelFormat.Pixel1bppIndexed && AtalaImage.Edition == LicenseEdition.Document)
					cmd = new ResampleDocumentCommand(Rectangle.Empty, new Size(image.Width, Convert.ToInt32(image.Height * ratio)), ResampleMethod.Default);
				else
					cmd = new ResampleCommand(new Size(image.Width, Convert.ToInt32(image.Height * ratio)), ResampleMethod.Default);

				return cmd.ApplyToImage(image);
			}
			else
				return image;
		}

		private void miPrint_Click(object sender, System.EventArgs e)
		{
			if(miIgnoreMargins.Checked)
				imagePrintDocument1.ScaleMode = Atalasoft.Imaging.WinControls.PrintScaleMode.FitToEdges;
			else
				imagePrintDocument1.ScaleMode = Atalasoft.Imaging.WinControls.PrintScaleMode.FitToMargins;

			this.imagePrintDocument1.PrinterSettings.MinimumPage=1;
			this.imagePrintDocument1.PrinterSettings.MaximumPage=pageCount;
			this.imagePrintDocument1.PrinterSettings.FromPage=1;
			this.imagePrintDocument1.PrinterSettings.ToPage=pageCount;

			if (this.printDialog1.ShowDialog(this) == DialogResult.OK)
			{
				this.imagePrintDocument1.Print();
			}
		}

		private void miPrintPreview_Click(object sender, System.EventArgs e)
		{
			if(miIgnoreMargins.Checked)
				imagePrintDocument1.ScaleMode = Atalasoft.Imaging.WinControls.PrintScaleMode.FitToEdges;
			else
				imagePrintDocument1.ScaleMode = Atalasoft.Imaging.WinControls.PrintScaleMode.FitToMargins;

			this.imagePrintDocument1.PrinterSettings.MinimumPage=1;
			this.imagePrintDocument1.PrinterSettings.MaximumPage=pageCount;
			this.imagePrintDocument1.PrinterSettings.FromPage=1;
			this.imagePrintDocument1.PrinterSettings.ToPage=pageCount;

			if (this.printDialog1.ShowDialog(this) == DialogResult.OK)
			{
				this.printPreviewDialog1.Width=this.ClientSize.Width;
				this.printPreviewDialog1.Height=this.ClientSize.Height;
				this.printPreviewDialog1.Top=0;
				this.printPreviewDialog1.Left=0;
				this.printPreviewDialog1.ShowDialog(this);
			}
		}

		private void miItem_DrawItem(object sender, System.Windows.Forms.DrawItemEventArgs e)
		{
			MenuItem mi = (MenuItem)sender;
			string myCaption = mi.Text.Replace("&","");

			// Create a Brush and a Font with which to draw the item.
			Brush myBrush = System.Drawing.Brushes.Navy;
			Font myFont = new Font(this.Font.FontFamily, 24, FontStyle.Regular, GraphicsUnit.Pixel);
			SizeF mySizeF = e.Graphics.MeasureString(myCaption, myFont);
			
			Color background = e.BackColor;

			if((e.State & DrawItemState.Selected) == DrawItemState.Selected || (e.State & DrawItemState.HotLight) == DrawItemState.HotLight)
				background = Color.CornflowerBlue;
			e.Graphics.FillRectangle(new SolidBrush(background),e.Bounds);
			
			e.Graphics.DrawString(myCaption, myFont, myBrush, e.Bounds.X+(e.Bounds.Height/2), e.Bounds.Y);        

			if((e.State & DrawItemState.Checked) == DrawItemState.Checked)
			{
				// Draw a check mark
				e.Graphics.DrawLines(new Pen(myBrush,e.Bounds.Height/10),new Point[]{new Point(e.Bounds.X,e.Bounds.Y+(e.Bounds.Height/2)),
																						new Point(e.Bounds.X+(e.Bounds.Height/4),e.Bounds.Y+((e.Bounds.Height/4)*3)),
																						new Point(e.Bounds.X+(e.Bounds.Height/2),e.Bounds.Y+(e.Bounds.Height/4))});
			}			
		}

		private void miItem_MeasureItem(object sender, System.Windows.Forms.MeasureItemEventArgs e)
		{
			MenuItem mi = (MenuItem)sender;
			string myCaption = mi.Text;

			Font myFont = new Font(this.Font.FontFamily, 24, FontStyle.Regular, GraphicsUnit.Pixel);
			SizeF mySizeF = e.Graphics.MeasureString(myCaption, myFont);

			e.ItemHeight = Convert.ToInt32(mySizeF.Height)+2;
			e.ItemWidth = Convert.ToInt32(mySizeF.Width)+(e.ItemHeight/2);
		}

		private void imagePrintDocument1_PrintImage(object sender, Atalasoft.Imaging.WinControls.PrintImageEventArgs e)
		{
			if(e.Image.Resolution.X==0 || e.Image.Resolution.Y==0)
				return;
			int imgWidth = e.Image.Width*e.PageSettings.PrinterResolution.X/e.Image.Resolution.X;
			int imgHeight = e.Image.Height*e.PageSettings.PrinterResolution.Y/e.Image.Resolution.Y;
			Size imgSize = new Size(imgWidth,imgHeight);

			if(imgWidth<e.MarginBounds.Width && imgHeight<e.MarginBounds.Height)
				e.DestRectangle = new Rectangle(e.MarginBounds.Location,imgSize);
		}

		private void miIgnoreMargins_Click(object sender, System.EventArgs e)
		{
			miIgnoreMargins.Checked=!miIgnoreMargins.Checked;
		}

		private void miPageSetup_Click(object sender, System.EventArgs e)
		{

			if(pageSetupDialog1.ShowDialog(this)==DialogResult.OK)
			{
				imagePrintDocument1.PrinterSettings=pageSetupDialog1.PrinterSettings;
				imagePrintDocument1.DefaultPageSettings=pageSetupDialog1.PageSettings;
			}
		}		
	}
}
