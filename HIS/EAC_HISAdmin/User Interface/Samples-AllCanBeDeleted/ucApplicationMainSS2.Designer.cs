﻿namespace EAC_HISAdmin.User_Interface
{
    partial class ucApplicationMainSS2
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
            this.btnGotoApplicationMain = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnGoToSS1 = new System.Windows.Forms.Button();
            this.btnReturnToSender = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.btnInfo = new System.Windows.Forms.Button();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnGotoApplicationMain
            // 
            this.btnGotoApplicationMain.Location = new System.Drawing.Point(6, 48);
            this.btnGotoApplicationMain.Name = "btnGotoApplicationMain";
            this.btnGotoApplicationMain.Size = new System.Drawing.Size(123, 23);
            this.btnGotoApplicationMain.TabIndex = 5;
            this.btnGotoApplicationMain.Text = "GoTo ApplicationMain";
            this.btnGotoApplicationMain.UseVisualStyleBackColor = true;
            this.btnGotoApplicationMain.Click += new System.EventHandler(this.btnGotoApplicationMain_Click_1);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(200, 74);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(100, 20);
            this.textBox1.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(26, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(51, 16);
            this.label1.TabIndex = 1;
            this.label1.Text = "label1";
            // 
            // btnGoToSS1
            // 
            this.btnGoToSS1.Location = new System.Drawing.Point(6, 19);
            this.btnGoToSS1.Name = "btnGoToSS1";
            this.btnGoToSS1.Size = new System.Drawing.Size(123, 23);
            this.btnGoToSS1.TabIndex = 0;
            this.btnGoToSS1.Text = "GoTo SS1";
            this.btnGoToSS1.UseVisualStyleBackColor = true;
            this.btnGoToSS1.Click += new System.EventHandler(this.btnGoToSearch_Click);
            // 
            // btnReturnToSender
            // 
            this.btnReturnToSender.Location = new System.Drawing.Point(200, 19);
            this.btnReturnToSender.Name = "btnReturnToSender";
            this.btnReturnToSender.Size = new System.Drawing.Size(103, 23);
            this.btnReturnToSender.TabIndex = 27;
            this.btnReturnToSender.Text = "Return to Sender";
            this.btnReturnToSender.UseVisualStyleBackColor = true;
            this.btnReturnToSender.Click += new System.EventHandler(this.btnReturnToSender_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.textBox1);
            this.groupBox2.Controls.Add(this.btnReturnToSender);
            this.groupBox2.Controls.Add(this.btnGoToSS1);
            this.groupBox2.Controls.Add(this.btnGotoApplicationMain);
            this.groupBox2.Location = new System.Drawing.Point(29, 54);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(309, 100);
            this.groupBox2.TabIndex = 30;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Screen Swapping";
            // 
            // btnInfo
            // 
            this.btnInfo.BackgroundImage = global::EAC_HISAdmin.Properties.Resources.Info;
            this.btnInfo.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnInfo.Location = new System.Drawing.Point(609, 20);
            this.btnInfo.Name = "btnInfo";
            this.btnInfo.Size = new System.Drawing.Size(17, 23);
            this.btnInfo.TabIndex = 36;
            this.btnInfo.UseVisualStyleBackColor = true;
            // 
            // ucApplicationMainSS2
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.btnInfo);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.label1);
            this.Name = "ucApplicationMainSS2";
            this.Size = new System.Drawing.Size(640, 480);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnGoToSS1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button btnGotoApplicationMain;
        private System.Windows.Forms.Button btnReturnToSender;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button btnInfo;
    }
}
