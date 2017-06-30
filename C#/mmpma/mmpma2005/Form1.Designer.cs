namespace mmpma
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.bGo = new System.Windows.Forms.Button();
            this.listView1 = new System.Windows.Forms.ListView();
            this.attachment_id = new System.Windows.Forms.ColumnHeader();
            this.cpr_id = new System.Windows.Forms.ColumnHeader();
            this.merged_from_cpr_id = new System.Windows.Forms.ColumnHeader();
            this.filename = new System.Windows.Forms.ColumnHeader();
            this.should_be_here = new System.Windows.Forms.ColumnHeader();
            this.might_be_here = new System.Windows.Forms.ColumnHeader();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.tGoodCount = new System.Windows.Forms.TextBox();
            this.tFixedCount = new System.Windows.Forms.TextBox();
            this.listView2 = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader5 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader6 = new System.Windows.Forms.ColumnHeader();
            this.SuspendLayout();
            // 
            // bGo
            // 
            this.bGo.Location = new System.Drawing.Point(3, 1);
            this.bGo.Name = "bGo";
            this.bGo.Size = new System.Drawing.Size(75, 23);
            this.bGo.TabIndex = 4;
            this.bGo.Text = "&Go";
            this.bGo.UseVisualStyleBackColor = true;
            this.bGo.Click += new System.EventHandler(this.bGo_Click);
            // 
            // listView1
            // 
            this.listView1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.listView1.BackColor = System.Drawing.Color.LightGray;
            this.listView1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.listView1.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.attachment_id,
            this.cpr_id,
            this.merged_from_cpr_id,
            this.filename,
            this.should_be_here,
            this.might_be_here});
            this.listView1.GridLines = true;
            this.listView1.Location = new System.Drawing.Point(2, 43);
            this.listView1.Name = "listView1";
            this.listView1.Size = new System.Drawing.Size(416, 112);
            this.listView1.TabIndex = 91;
            this.listView1.UseCompatibleStateImageBehavior = false;
            this.listView1.View = System.Windows.Forms.View.Details;
            // 
            // attachment_id
            // 
            this.attachment_id.DisplayIndex = 2;
            this.attachment_id.Text = "attachment_id";
            // 
            // cpr_id
            // 
            this.cpr_id.DisplayIndex = 0;
            this.cpr_id.Text = "cpr_id";
            // 
            // merged_from_cpr_id
            // 
            this.merged_from_cpr_id.DisplayIndex = 1;
            this.merged_from_cpr_id.Text = "merged_from_cpr_id";
            // 
            // filename
            // 
            this.filename.Text = "filename";
            // 
            // should_be_here
            // 
            this.should_be_here.Text = "should_be_here";
            // 
            // might_be_here
            // 
            this.might_be_here.Text = "might_be_here";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(11, 168);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(243, 13);
            this.label1.TabIndex = 92;
            this.label1.Text = "Attachment files already in the right place";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(13, 206);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(233, 13);
            this.label2.TabIndex = 93;
            this.label2.Text = "Attachment files move to the right place";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(13, 241);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(166, 13);
            this.label3.TabIndex = 94;
            this.label3.Text = "Attachment files still missing";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(12, 27);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(226, 13);
            this.label4.TabIndex = 95;
            this.label4.Text = "Attachments with possible missing files";
            // 
            // tGoodCount
            // 
            this.tGoodCount.BackColor = System.Drawing.Color.LightGray;
            this.tGoodCount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tGoodCount.Location = new System.Drawing.Point(260, 168);
            this.tGoodCount.Name = "tGoodCount";
            this.tGoodCount.Size = new System.Drawing.Size(100, 20);
            this.tGoodCount.TabIndex = 96;
            // 
            // tFixedCount
            // 
            this.tFixedCount.BackColor = System.Drawing.Color.LightGray;
            this.tFixedCount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tFixedCount.Location = new System.Drawing.Point(260, 203);
            this.tFixedCount.Name = "tFixedCount";
            this.tFixedCount.Size = new System.Drawing.Size(100, 20);
            this.tFixedCount.TabIndex = 97;
            // 
            // listView2
            // 
            this.listView2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.listView2.BackColor = System.Drawing.Color.LightGray;
            this.listView2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.listView2.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4,
            this.columnHeader5,
            this.columnHeader6});
            this.listView2.GridLines = true;
            this.listView2.Location = new System.Drawing.Point(14, 258);
            this.listView2.Name = "listView2";
            this.listView2.Size = new System.Drawing.Size(397, 107);
            this.listView2.TabIndex = 98;
            this.listView2.UseCompatibleStateImageBehavior = false;
            this.listView2.View = System.Windows.Forms.View.Details;
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "attachment_id";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "cpr_id";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "merged_from_cpr_id";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "filename";
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "should_be_here";
            this.columnHeader5.Width = 73;
            // 
            // columnHeader6
            // 
            this.columnHeader6.Text = "might_be_here";
            this.columnHeader6.Width = 66;
            // 
            // Form1
            // 
            this.AcceptButton = this.bGo;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(426, 382);
            this.Controls.Add(this.listView2);
            this.Controls.Add(this.tFixedCount);
            this.Controls.Add(this.tGoodCount);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.listView1);
            this.Controls.Add(this.bGo);
            this.Name = "Form1";
            this.Text = "Migrated Merged Patients Missing Attachments";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button bGo;
        private System.Windows.Forms.ListView listView1;
        private System.Windows.Forms.ColumnHeader cpr_id;
        private System.Windows.Forms.ColumnHeader merged_from_cpr_id;
        private System.Windows.Forms.ColumnHeader attachment_id;
        private System.Windows.Forms.ColumnHeader filename;
        private System.Windows.Forms.ColumnHeader should_be_here;
        private System.Windows.Forms.ColumnHeader might_be_here;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tGoodCount;
        private System.Windows.Forms.TextBox tFixedCount;
        private System.Windows.Forms.ListView listView2;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
        private System.Windows.Forms.ColumnHeader columnHeader6;
    }
}

