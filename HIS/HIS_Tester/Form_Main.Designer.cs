namespace HIS_Tester
{
    partial class Form_Main
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
            this.components = new System.ComponentModel.Container();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.btnProcessProvisioningFile = new System.Windows.Forms.Button();
            this.btnGetAttributesERBL = new System.Windows.Forms.Button();
            this.btnSaveAttributesERBL = new System.Windows.Forms.Button();
            this.btnHISSchemaForm = new System.Windows.Forms.Button();
            this.btnHISConstrainedValuesForm = new System.Windows.Forms.Button();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.idDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.lastChangedDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.btnHISItemExplorerForm = new System.Windows.Forms.Button();
            this.btnHISSchema2Form = new System.Windows.Forms.Button();
            this.btnItemDetailForm = new System.Windows.Forms.Button();
            this.btnItemDetail2Form = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).BeginInit();
            this.SuspendLayout();
            // 
            // openFileDialog
            // 
            this.openFileDialog.FileName = "HISSchema.xml";
            // 
            // btnProcessProvisioningFile
            // 
            this.btnProcessProvisioningFile.Location = new System.Drawing.Point(10, 12);
            this.btnProcessProvisioningFile.Name = "btnProcessProvisioningFile";
            this.btnProcessProvisioningFile.Size = new System.Drawing.Size(84, 52);
            this.btnProcessProvisioningFile.TabIndex = 22;
            this.btnProcessProvisioningFile.Text = "Process Provisioning File";
            this.btnProcessProvisioningFile.UseVisualStyleBackColor = true;
            this.btnProcessProvisioningFile.Click += new System.EventHandler(this.btnProcessProvisioningFile_Click);
            // 
            // btnGetAttributesERBL
            // 
            this.btnGetAttributesERBL.Location = new System.Drawing.Point(10, 142);
            this.btnGetAttributesERBL.Name = "btnGetAttributesERBL";
            this.btnGetAttributesERBL.Size = new System.Drawing.Size(148, 23);
            this.btnGetAttributesERBL.TabIndex = 37;
            this.btnGetAttributesERBL.Text = "Get AttributesERBL";
            this.btnGetAttributesERBL.UseVisualStyleBackColor = true;
            this.btnGetAttributesERBL.Click += new System.EventHandler(this.btnGetAttributesERBL_Click);
            // 
            // btnSaveAttributesERBL
            // 
            this.btnSaveAttributesERBL.Location = new System.Drawing.Point(10, 171);
            this.btnSaveAttributesERBL.Name = "btnSaveAttributesERBL";
            this.btnSaveAttributesERBL.Size = new System.Drawing.Size(148, 23);
            this.btnSaveAttributesERBL.TabIndex = 38;
            this.btnSaveAttributesERBL.Text = "Save AttributesERBL";
            this.btnSaveAttributesERBL.UseVisualStyleBackColor = true;
            this.btnSaveAttributesERBL.Click += new System.EventHandler(this.btnSaveAttributesERBL_Click);
            // 
            // btnHISSchemaForm
            // 
            this.btnHISSchemaForm.Location = new System.Drawing.Point(195, 12);
            this.btnHISSchemaForm.Name = "btnHISSchemaForm";
            this.btnHISSchemaForm.Size = new System.Drawing.Size(159, 23);
            this.btnHISSchemaForm.TabIndex = 39;
            this.btnHISSchemaForm.Text = "HISSchema Form";
            this.btnHISSchemaForm.UseVisualStyleBackColor = true;
            this.btnHISSchemaForm.Click += new System.EventHandler(this.btnLoadHISSchemaForm_Click);
            // 
            // btnHISConstrainedValuesForm
            // 
            this.btnHISConstrainedValuesForm.Location = new System.Drawing.Point(375, 12);
            this.btnHISConstrainedValuesForm.Name = "btnHISConstrainedValuesForm";
            this.btnHISConstrainedValuesForm.Size = new System.Drawing.Size(159, 23);
            this.btnHISConstrainedValuesForm.TabIndex = 41;
            this.btnHISConstrainedValuesForm.Text = "HISConstrainedValues Form";
            this.btnHISConstrainedValuesForm.UseVisualStyleBackColor = true;
            this.btnHISConstrainedValuesForm.Click += new System.EventHandler(this.btnHISConstrainedValuesForm_Click);
            // 
            // dataGridView2
            // 
            this.dataGridView2.AutoGenerateColumns = false;
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idDataGridViewTextBoxColumn,
            this.nameDataGridViewTextBoxColumn,
            this.lastChangedDataGridViewTextBoxColumn});
            this.dataGridView2.DataSource = this.bindingSource1;
            this.dataGridView2.Location = new System.Drawing.Point(183, 144);
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.Size = new System.Drawing.Size(529, 280);
            this.dataGridView2.TabIndex = 36;
            this.dataGridView2.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView2_CellValueChanged);
            // 
            // idDataGridViewTextBoxColumn
            // 
            this.idDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.idDataGridViewTextBoxColumn.DataPropertyName = "Id";
            this.idDataGridViewTextBoxColumn.HeaderText = "Id";
            this.idDataGridViewTextBoxColumn.Name = "idDataGridViewTextBoxColumn";
            this.idDataGridViewTextBoxColumn.Width = 41;
            // 
            // nameDataGridViewTextBoxColumn
            // 
            this.nameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.nameDataGridViewTextBoxColumn.DataPropertyName = "Name";
            this.nameDataGridViewTextBoxColumn.HeaderText = "Name";
            this.nameDataGridViewTextBoxColumn.Name = "nameDataGridViewTextBoxColumn";
            this.nameDataGridViewTextBoxColumn.Width = 60;
            // 
            // lastChangedDataGridViewTextBoxColumn
            // 
            this.lastChangedDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.lastChangedDataGridViewTextBoxColumn.DataPropertyName = "LastChanged";
            this.lastChangedDataGridViewTextBoxColumn.HeaderText = "LastChanged";
            this.lastChangedDataGridViewTextBoxColumn.Name = "lastChangedDataGridViewTextBoxColumn";
            this.lastChangedDataGridViewTextBoxColumn.Width = 95;
            // 
            // bindingSource1
            // 
            this.bindingSource1.DataSource = typeof(HIS.Library.AttributesERBL);
            // 
            // btnHISItemExplorerForm
            // 
            this.btnHISItemExplorerForm.Location = new System.Drawing.Point(553, 12);
            this.btnHISItemExplorerForm.Name = "btnHISItemExplorerForm";
            this.btnHISItemExplorerForm.Size = new System.Drawing.Size(159, 23);
            this.btnHISItemExplorerForm.TabIndex = 42;
            this.btnHISItemExplorerForm.Text = "HIS Item Explorer Form";
            this.btnHISItemExplorerForm.UseVisualStyleBackColor = true;
            this.btnHISItemExplorerForm.Click += new System.EventHandler(this.btnHISItemExplorer_Click);
            // 
            // btnHISSchema2Form
            // 
            this.btnHISSchema2Form.Location = new System.Drawing.Point(195, 41);
            this.btnHISSchema2Form.Name = "btnHISSchema2Form";
            this.btnHISSchema2Form.Size = new System.Drawing.Size(159, 23);
            this.btnHISSchema2Form.TabIndex = 43;
            this.btnHISSchema2Form.Text = "HISSchema2 Form";
            this.btnHISSchema2Form.UseVisualStyleBackColor = true;
            this.btnHISSchema2Form.Click += new System.EventHandler(this.btnHISSchema2Form_Click);
            // 
            // btnItemDetailForm
            // 
            this.btnItemDetailForm.Location = new System.Drawing.Point(553, 41);
            this.btnItemDetailForm.Name = "btnItemDetailForm";
            this.btnItemDetailForm.Size = new System.Drawing.Size(159, 23);
            this.btnItemDetailForm.TabIndex = 44;
            this.btnItemDetailForm.Text = "HIS Item Detail Form";
            this.btnItemDetailForm.UseVisualStyleBackColor = true;
            this.btnItemDetailForm.Click += new System.EventHandler(this.btnItemDetailForm_Click);
            // 
            // btnItemDetail2Form
            // 
            this.btnItemDetail2Form.Location = new System.Drawing.Point(553, 70);
            this.btnItemDetail2Form.Name = "btnItemDetail2Form";
            this.btnItemDetail2Form.Size = new System.Drawing.Size(159, 23);
            this.btnItemDetail2Form.TabIndex = 45;
            this.btnItemDetail2Form.Text = "HIS Item Detail2 Form";
            this.btnItemDetail2Form.UseVisualStyleBackColor = true;
            this.btnItemDetail2Form.Click += new System.EventHandler(this.btnItemDetail2Form_Click);
            // 
            // Form_Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(897, 437);
            this.Controls.Add(this.btnItemDetail2Form);
            this.Controls.Add(this.btnItemDetailForm);
            this.Controls.Add(this.btnHISSchema2Form);
            this.Controls.Add(this.btnHISItemExplorerForm);
            this.Controls.Add(this.btnHISConstrainedValuesForm);
            this.Controls.Add(this.btnHISSchemaForm);
            this.Controls.Add(this.btnSaveAttributesERBL);
            this.Controls.Add(this.btnGetAttributesERBL);
            this.Controls.Add(this.dataGridView2);
            this.Controls.Add(this.btnProcessProvisioningFile);
            this.Name = "Form_Main";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.Button btnProcessProvisioningFile;
        private System.Windows.Forms.BindingSource bindingSource1;
        private System.Windows.Forms.Button btnGetAttributesERBL;
        private System.Windows.Forms.Button btnSaveAttributesERBL;
        private System.Windows.Forms.Button btnHISSchemaForm;
        private System.Windows.Forms.Button btnHISConstrainedValuesForm;
        private System.Windows.Forms.DataGridView dataGridView2;
        private System.Windows.Forms.Button btnHISItemExplorerForm;
        private System.Windows.Forms.Button btnHISSchema2Form;
        private System.Windows.Forms.Button btnItemDetailForm;
        private System.Windows.Forms.Button btnItemDetail2Form;
        private System.Windows.Forms.DataGridViewTextBoxColumn idDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn nameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn lastChangedDataGridViewTextBoxColumn;
    }
}

