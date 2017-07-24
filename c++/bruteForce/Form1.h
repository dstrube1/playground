#pragma once

#include "ftp.h"

namespace bruteForce
{
	using namespace Ftp;
	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary> 
	/// Summary for Form1
	///
	/// WARNING: If you change the name of this class, you will need to change the 
	///          'Resource File Name' property for the managed resource compiler tool 
	///          associated with all .resx files this class depends on.  Otherwise,
	///          the designers will not be able to interact properly with localized
	///          resources associated with this form.
	/// </summary>
	public __gc class Form1 : public System::Windows::Forms::Form
	{	
	public:
		CFtp* m_Ftp;
		Form1(void)
		{
			InitializeComponent();
		}
  
	protected:
		void Dispose(Boolean disposing)
		{
			if (disposing && components)
			{
				components->Dispose();
			}
			__super::Dispose(disposing);
		}
	private: System::Windows::Forms::Button *  Connect;
	private: System::Windows::Forms::Button *  Disconnect;
	private: System::Windows::Forms::TextBox *  IPAddress;
	private: System::Windows::Forms::Label *  label1;

	private: System::Windows::Forms::Label *  label2;
	private: System::Windows::Forms::Label *  label3;
	private: System::Windows::Forms::TextBox *  Port;
	private: System::Windows::Forms::TextBox *  Username;
	private: System::Windows::Forms::Label *  label5;
	private: System::Windows::Forms::TextBox *  Password;



	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container * components;

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->Connect = new System::Windows::Forms::Button();
			this->Disconnect = new System::Windows::Forms::Button();
			this->IPAddress = new System::Windows::Forms::TextBox();
			this->label1 = new System::Windows::Forms::Label();
			this->Port = new System::Windows::Forms::TextBox();
			this->label2 = new System::Windows::Forms::Label();
			this->label3 = new System::Windows::Forms::Label();
			this->Username = new System::Windows::Forms::TextBox();
			this->label5 = new System::Windows::Forms::Label();
			this->Password = new System::Windows::Forms::TextBox();
			this->SuspendLayout();
			// 
			// Connect
			// 
			this->Connect->Location = System::Drawing::Point(312, 24);
			this->Connect->Name = S"Connect";
			this->Connect->Size = System::Drawing::Size(72, 24);
			this->Connect->TabIndex = 0;
			this->Connect->Text = S"Connect";
			this->Connect->Click += new System::EventHandler(this, Connect_Click);
			// 
			// Disconnect
			// 
			this->Disconnect->Location = System::Drawing::Point(312, 56);
			this->Disconnect->Name = S"Disconnect";
			this->Disconnect->Size = System::Drawing::Size(72, 24);
			this->Disconnect->TabIndex = 1;
			this->Disconnect->Text = S"Disconnect";
			this->Disconnect->Click += new System::EventHandler(this, Disconnect_Click);
			// 
			// IPAddress
			// 
			this->IPAddress->Location = System::Drawing::Point(120, 16);
			this->IPAddress->Name = S"IPAddress";
			this->IPAddress->Size = System::Drawing::Size(168, 20);
			this->IPAddress->TabIndex = 2;
			this->IPAddress->Text = S"";
			// 
			// label1
			// 
			this->label1->Location = System::Drawing::Point(16, 16);
			this->label1->Name = S"label1";
			this->label1->Size = System::Drawing::Size(64, 24);
			this->label1->TabIndex = 3;
			this->label1->Text = S"Ip Address:";
			// 
			// Port
			// 
			this->Port->Location = System::Drawing::Point(120, 48);
			this->Port->MaxLength = 6;
			this->Port->Name = S"Port";
			this->Port->Size = System::Drawing::Size(48, 20);
			this->Port->TabIndex = 4;
			this->Port->Text = S"";
			this->Port->WordWrap = false;
			// 
			// label2
			// 
			this->label2->Location = System::Drawing::Point(16, 48);
			this->label2->Name = S"label2";
			this->label2->Size = System::Drawing::Size(64, 24);
			this->label2->TabIndex = 5;
			this->label2->Text = S"Port:";
			// 
			// label3
			// 
			this->label3->Location = System::Drawing::Point(16, 80);
			this->label3->Name = S"label3";
			this->label3->Size = System::Drawing::Size(64, 24);
			this->label3->TabIndex = 7;
			this->label3->Text = S"User name:";
			// 
			// Username
			// 
			this->Username->Location = System::Drawing::Point(120, 80);
			this->Username->Name = S"Username";
			this->Username->Size = System::Drawing::Size(168, 20);
			this->Username->TabIndex = 6;
			this->Username->Text = S"";
			// 
			// label5
			// 
			this->label5->Location = System::Drawing::Point(16, 112);
			this->label5->Name = S"label5";
			this->label5->Size = System::Drawing::Size(64, 24);
			this->label5->TabIndex = 9;
			this->label5->Text = S"Password:";
			// 
			// Password
			// 
			this->Password->Location = System::Drawing::Point(120, 112);
			this->Password->Name = S"Password";
			this->Password->Size = System::Drawing::Size(168, 20);
			this->Password->TabIndex = 8;
			this->Password->Text = S"";
			// 
			// Form1
			// 
			this->AutoScaleBaseSize = System::Drawing::Size(5, 13);
			this->ClientSize = System::Drawing::Size(392, 150);
			this->Controls->Add(this->label5);
			this->Controls->Add(this->Password);
			this->Controls->Add(this->label3);
			this->Controls->Add(this->Username);
			this->Controls->Add(this->label2);
			this->Controls->Add(this->Port);
			this->Controls->Add(this->label1);
			this->Controls->Add(this->IPAddress);
			this->Controls->Add(this->Disconnect);
			this->Controls->Add(this->Connect);
			this->Name = S"Form1";
			this->Text = S"Form1";
			this->ResumeLayout(false);

		}	
	private: System::Void Connect_Click(System::Object *  sender, System::EventArgs *  e)
			 {
				if(m_Ftp == NULL) m_Ftp = new CFtp;
				if(m_Ftp->Connected) return;

				String* ipAddress = this->IPAddress->Text;
				String* userName = this->Username->Text;
				String* password = this->Password->Text;
				String* port = this->Port->Text;
				int iPort = Convert::ToInt32(port);

				m_Ftp->Initialise(ipAddress,userName,password,iPort);
				m_Ftp->Connect();
//				
			 }

	private: System::Void Disconnect_Click(System::Object *  sender, System::EventArgs *  e)
			 {
				 if(m_Ftp->Connected) m_Ftp->Disconnect();
			 }



};
}


