﻿namespace EAC_HISAdmin.User_Interface
{
    partial class ucStarterScreenWPF
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.elementHost1 = new System.Windows.Forms.Integration.ElementHost();
            this.label1 = new System.Windows.Forms.Label();
            this.btnReturnToSender = new System.Windows.Forms.Button();
            this.elementHost2 = new System.Windows.Forms.Integration.ElementHost();
            this.elementHost3 = new System.Windows.Forms.Integration.ElementHost();
            this.admin_Attributes1 = new EAC_HISAdmin.User_Interface.User_Controls_WPF.Admin_Attributes();
            this.elementHost4 = new System.Windows.Forms.Integration.ElementHost();
            this.cylonEyeBall1 = new HIS_Administration.User_Interface.User_Controls.CylonEyeBall();
            this.SuspendLayout();
            // 
            // elementHost1
            // 
            this.elementHost1.BackColor = System.Drawing.Color.LightBlue;
            this.elementHost1.ForeColor = System.Drawing.Color.CornflowerBlue;
            this.elementHost1.Location = new System.Drawing.Point(0, 0);
            this.elementHost1.Name = "elementHost1";
            this.elementHost1.Size = new System.Drawing.Size(640, 477);
            this.elementHost1.TabIndex = 0;
            this.elementHost1.Text = "elementHost1";
            this.elementHost1.Child = null;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 14);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "label1";
            // 
            // btnReturnToSender
            // 
            this.btnReturnToSender.Location = new System.Drawing.Point(530, 444);
            this.btnReturnToSender.Name = "btnReturnToSender";
            this.btnReturnToSender.Size = new System.Drawing.Size(96, 23);
            this.btnReturnToSender.TabIndex = 2;
            this.btnReturnToSender.Text = "Return to Sender";
            this.btnReturnToSender.UseVisualStyleBackColor = true;
            this.btnReturnToSender.Click += new System.EventHandler(this.btnReturnToSender_Click);
            // 
            // elementHost2
            // 
            this.elementHost2.Location = new System.Drawing.Point(17, 30);
            this.elementHost2.Name = "elementHost2";
            this.elementHost2.Size = new System.Drawing.Size(609, 395);
            this.elementHost2.TabIndex = 4;
            this.elementHost2.Text = "elementHost2";
            this.elementHost2.Child = null;
            // 
            // elementHost3
            // 
            this.elementHost3.Location = new System.Drawing.Point(17, 30);
            this.elementHost3.Name = "elementHost3";
            this.elementHost3.Size = new System.Drawing.Size(475, 283);
            this.elementHost3.TabIndex = 5;
            this.elementHost3.Text = "elementHost3";
            this.elementHost3.Child = this.admin_Attributes1;
            // 
            // elementHost4
            // 
            this.elementHost4.Location = new System.Drawing.Point(61, 319);
            this.elementHost4.Name = "elementHost4";
            this.elementHost4.Size = new System.Drawing.Size(200, 100);
            this.elementHost4.TabIndex = 6;
            this.elementHost4.Text = "elementHost4";
            this.elementHost4.Child = this.cylonEyeBall1;
            // 
            // ucStarterScreenWPF
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.elementHost4);
            this.Controls.Add(this.elementHost3);
            this.Controls.Add(this.elementHost2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnReturnToSender);
            this.Controls.Add(this.elementHost1);
            this.Name = "ucStarterScreenWPF";
            this.Size = new System.Drawing.Size(640, 480);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Integration.ElementHost elementHost1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnReturnToSender;
        private System.Windows.Forms.Integration.ElementHost elementHost2;
        private System.Windows.Forms.Integration.ElementHost elementHost3;
        private User_Controls_WPF.Admin_Attributes admin_Attributes1;
        private System.Windows.Forms.Integration.ElementHost elementHost4;
        private HIS_Administration.User_Interface.User_Controls.CylonEyeBall cylonEyeBall1;


    }
}
