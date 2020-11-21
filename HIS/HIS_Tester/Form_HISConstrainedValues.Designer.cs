namespace HIS_Tester
{
    partial class Form_HISConstrainedValues
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
            this.lblConstrainedValueLists = new System.Windows.Forms.Label();
            this.lblConstrainedValues = new System.Windows.Forms.Label();
            this.dgvConstrainedValues = new System.Windows.Forms.DataGridView();
            this.idDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.constrainedValueListIdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.valueDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ordinalDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.descriptionDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.lastChangedDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.constrainedValuesECBLBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.dgvConstrainedValueLists = new System.Windows.Forms.DataGridView();
            this.idDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.descriptionDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nbrItemsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataTypeIdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.lastChangedDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.constrainedValueListsECBLBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.btnLoadHISSchema = new System.Windows.Forms.Button();
            this.lblLoadHISSchema = new System.Windows.Forms.Label();
            this.lblTotalTime = new System.Windows.Forms.Label();
            this.constrainedValuesECBLDataGridView = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dgvConstrainedValues)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.constrainedValuesECBLBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvConstrainedValueLists)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.constrainedValueListsECBLBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.constrainedValuesECBLDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // lblConstrainedValueLists
            // 
            this.lblConstrainedValueLists.AutoSize = true;
            this.lblConstrainedValueLists.Location = new System.Drawing.Point(9, 71);
            this.lblConstrainedValueLists.Name = "lblConstrainedValueLists";
            this.lblConstrainedValueLists.Size = new System.Drawing.Size(114, 13);
            this.lblConstrainedValueLists.TabIndex = 26;
            this.lblConstrainedValueLists.Text = "ConstrainedValue Lists";
            // 
            // lblConstrainedValues
            // 
            this.lblConstrainedValues.AutoSize = true;
            this.lblConstrainedValues.Location = new System.Drawing.Point(12, 342);
            this.lblConstrainedValues.Name = "lblConstrainedValues";
            this.lblConstrainedValues.Size = new System.Drawing.Size(95, 13);
            this.lblConstrainedValues.TabIndex = 34;
            this.lblConstrainedValues.Text = "ConstrainedValues";
            // 
            // dgvConstrainedValues
            // 
            this.dgvConstrainedValues.AutoGenerateColumns = false;
            this.dgvConstrainedValues.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvConstrainedValues.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idDataGridViewTextBoxColumn1,
            this.constrainedValueListIdDataGridViewTextBoxColumn,
            this.valueDataGridViewTextBoxColumn,
            this.ordinalDataGridViewTextBoxColumn,
            this.descriptionDataGridViewTextBoxColumn1,
            this.lastChangedDataGridViewTextBoxColumn1});
            this.dgvConstrainedValues.DataSource = this.constrainedValuesECBLBindingSource;
            this.dgvConstrainedValues.Location = new System.Drawing.Point(12, 358);
            this.dgvConstrainedValues.Name = "dgvConstrainedValues";
            this.dgvConstrainedValues.Size = new System.Drawing.Size(872, 239);
            this.dgvConstrainedValues.TabIndex = 33;
            // 
            // idDataGridViewTextBoxColumn1
            // 
            this.idDataGridViewTextBoxColumn1.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.idDataGridViewTextBoxColumn1.DataPropertyName = "Id";
            this.idDataGridViewTextBoxColumn1.HeaderText = "Id";
            this.idDataGridViewTextBoxColumn1.Name = "idDataGridViewTextBoxColumn1";
            this.idDataGridViewTextBoxColumn1.Width = 41;
            // 
            // constrainedValueListIdDataGridViewTextBoxColumn
            // 
            this.constrainedValueListIdDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.constrainedValueListIdDataGridViewTextBoxColumn.DataPropertyName = "ConstrainedValueListId";
            this.constrainedValueListIdDataGridViewTextBoxColumn.HeaderText = "ConstrainedValueListId";
            this.constrainedValueListIdDataGridViewTextBoxColumn.Name = "constrainedValueListIdDataGridViewTextBoxColumn";
            this.constrainedValueListIdDataGridViewTextBoxColumn.Width = 140;
            // 
            // valueDataGridViewTextBoxColumn
            // 
            this.valueDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.valueDataGridViewTextBoxColumn.DataPropertyName = "Value";
            this.valueDataGridViewTextBoxColumn.HeaderText = "Value";
            this.valueDataGridViewTextBoxColumn.Name = "valueDataGridViewTextBoxColumn";
            this.valueDataGridViewTextBoxColumn.Width = 59;
            // 
            // ordinalDataGridViewTextBoxColumn
            // 
            this.ordinalDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.ordinalDataGridViewTextBoxColumn.DataPropertyName = "Ordinal";
            this.ordinalDataGridViewTextBoxColumn.HeaderText = "Ordinal";
            this.ordinalDataGridViewTextBoxColumn.Name = "ordinalDataGridViewTextBoxColumn";
            this.ordinalDataGridViewTextBoxColumn.Width = 65;
            // 
            // descriptionDataGridViewTextBoxColumn1
            // 
            this.descriptionDataGridViewTextBoxColumn1.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.descriptionDataGridViewTextBoxColumn1.DataPropertyName = "Description";
            this.descriptionDataGridViewTextBoxColumn1.HeaderText = "Description";
            this.descriptionDataGridViewTextBoxColumn1.Name = "descriptionDataGridViewTextBoxColumn1";
            this.descriptionDataGridViewTextBoxColumn1.Width = 85;
            // 
            // lastChangedDataGridViewTextBoxColumn1
            // 
            this.lastChangedDataGridViewTextBoxColumn1.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.lastChangedDataGridViewTextBoxColumn1.DataPropertyName = "LastChanged";
            this.lastChangedDataGridViewTextBoxColumn1.HeaderText = "LastChanged";
            this.lastChangedDataGridViewTextBoxColumn1.Name = "lastChangedDataGridViewTextBoxColumn1";
            this.lastChangedDataGridViewTextBoxColumn1.Width = 95;
            // 
            // constrainedValuesECBLBindingSource
            // 
            this.constrainedValuesECBLBindingSource.DataSource = typeof(HIS.Library.ConstrainedValuesECBL);
            // 
            // dgvConstrainedValueLists
            // 
            this.dgvConstrainedValueLists.AutoGenerateColumns = false;
            this.dgvConstrainedValueLists.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvConstrainedValueLists.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idDataGridViewTextBoxColumn,
            this.nameDataGridViewTextBoxColumn,
            this.descriptionDataGridViewTextBoxColumn,
            this.nbrItemsDataGridViewTextBoxColumn,
            this.dataTypeIdDataGridViewTextBoxColumn,
            this.lastChangedDataGridViewTextBoxColumn});
            this.dgvConstrainedValueLists.DataSource = this.constrainedValueListsECBLBindingSource;
            this.dgvConstrainedValueLists.Location = new System.Drawing.Point(12, 87);
            this.dgvConstrainedValueLists.Name = "dgvConstrainedValueLists";
            this.dgvConstrainedValueLists.Size = new System.Drawing.Size(872, 239);
            this.dgvConstrainedValueLists.TabIndex = 25;
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
            // descriptionDataGridViewTextBoxColumn
            // 
            this.descriptionDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.descriptionDataGridViewTextBoxColumn.DataPropertyName = "Description";
            this.descriptionDataGridViewTextBoxColumn.HeaderText = "Description";
            this.descriptionDataGridViewTextBoxColumn.Name = "descriptionDataGridViewTextBoxColumn";
            this.descriptionDataGridViewTextBoxColumn.Width = 85;
            // 
            // nbrItemsDataGridViewTextBoxColumn
            // 
            this.nbrItemsDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.nbrItemsDataGridViewTextBoxColumn.DataPropertyName = "NbrItems";
            this.nbrItemsDataGridViewTextBoxColumn.HeaderText = "NbrItems";
            this.nbrItemsDataGridViewTextBoxColumn.Name = "nbrItemsDataGridViewTextBoxColumn";
            this.nbrItemsDataGridViewTextBoxColumn.Width = 74;
            // 
            // dataTypeIdDataGridViewTextBoxColumn
            // 
            this.dataTypeIdDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.dataTypeIdDataGridViewTextBoxColumn.DataPropertyName = "DataTypeId";
            this.dataTypeIdDataGridViewTextBoxColumn.HeaderText = "DataTypeId";
            this.dataTypeIdDataGridViewTextBoxColumn.Name = "dataTypeIdDataGridViewTextBoxColumn";
            this.dataTypeIdDataGridViewTextBoxColumn.Width = 88;
            // 
            // lastChangedDataGridViewTextBoxColumn
            // 
            this.lastChangedDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.lastChangedDataGridViewTextBoxColumn.DataPropertyName = "LastChanged";
            this.lastChangedDataGridViewTextBoxColumn.HeaderText = "LastChanged";
            this.lastChangedDataGridViewTextBoxColumn.Name = "lastChangedDataGridViewTextBoxColumn";
            this.lastChangedDataGridViewTextBoxColumn.Width = 95;
            // 
            // constrainedValueListsECBLBindingSource
            // 
            this.constrainedValueListsECBLBindingSource.DataSource = typeof(HIS.Library.ConstrainedValueListsECBL);
            // 
            // btnLoadHISSchema
            // 
            this.btnLoadHISSchema.Location = new System.Drawing.Point(15, 10);
            this.btnLoadHISSchema.Name = "btnLoadHISSchema";
            this.btnLoadHISSchema.Size = new System.Drawing.Size(129, 23);
            this.btnLoadHISSchema.TabIndex = 35;
            this.btnLoadHISSchema.Text = "Load HISSchema";
            this.btnLoadHISSchema.UseVisualStyleBackColor = true;
            this.btnLoadHISSchema.Click += new System.EventHandler(this.btnLoadHISSchema_Click);
            // 
            // lblLoadHISSchema
            // 
            this.lblLoadHISSchema.AutoSize = true;
            this.lblLoadHISSchema.Location = new System.Drawing.Point(163, 15);
            this.lblLoadHISSchema.Name = "lblLoadHISSchema";
            this.lblLoadHISSchema.Size = new System.Drawing.Size(57, 13);
            this.lblLoadHISSchema.TabIndex = 36;
            this.lblLoadHISSchema.Text = "Total Time";
            // 
            // lblTotalTime
            // 
            this.lblTotalTime.AutoSize = true;
            this.lblTotalTime.Location = new System.Drawing.Point(163, 38);
            this.lblTotalTime.Name = "lblTotalTime";
            this.lblTotalTime.Size = new System.Drawing.Size(57, 13);
            this.lblTotalTime.TabIndex = 37;
            this.lblTotalTime.Text = "Total Time";
            // 
            // constrainedValuesECBLDataGridView
            // 
            this.constrainedValuesECBLDataGridView.AutoGenerateColumns = false;
            this.constrainedValuesECBLDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.constrainedValuesECBLDataGridView.DataMember = "Id";
            this.constrainedValuesECBLDataGridView.DataSource = this.constrainedValueListsECBLBindingSource;
            this.constrainedValuesECBLDataGridView.Location = new System.Drawing.Point(12, 618);
            this.constrainedValuesECBLDataGridView.Name = "constrainedValuesECBLDataGridView";
            this.constrainedValuesECBLDataGridView.Size = new System.Drawing.Size(872, 126);
            this.constrainedValuesECBLDataGridView.TabIndex = 37;
            // 
            // Form_HISConstrainedValues
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(951, 761);
            this.Controls.Add(this.constrainedValuesECBLDataGridView);
            this.Controls.Add(this.lblTotalTime);
            this.Controls.Add(this.lblLoadHISSchema);
            this.Controls.Add(this.btnLoadHISSchema);
            this.Controls.Add(this.lblConstrainedValues);
            this.Controls.Add(this.dgvConstrainedValues);
            this.Controls.Add(this.lblConstrainedValueLists);
            this.Controls.Add(this.dgvConstrainedValueLists);
            this.Name = "Form_HISConstrainedValues";
            this.Text = "Form_HISConstrainedValues";
            ((System.ComponentModel.ISupportInitialize)(this.dgvConstrainedValues)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.constrainedValuesECBLBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvConstrainedValueLists)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.constrainedValueListsECBLBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.constrainedValuesECBLDataGridView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblConstrainedValueLists;
        private System.Windows.Forms.Label lblConstrainedValues;
        private System.Windows.Forms.DataGridView dgvConstrainedValues;
        private System.Windows.Forms.BindingSource constrainedValuesECBLBindingSource;
        private System.Windows.Forms.DataGridView dgvConstrainedValueLists;
        private System.Windows.Forms.BindingSource constrainedValueListsECBLBindingSource;
        private System.Windows.Forms.Button btnLoadHISSchema;
        private System.Windows.Forms.Label lblLoadHISSchema;
        private System.Windows.Forms.Label lblTotalTime;
        private System.Windows.Forms.DataGridViewTextBoxColumn idDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn nameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn descriptionDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn nbrItemsDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataTypeIdDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn lastChangedDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn idDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn constrainedValueListIdDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn valueDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn ordinalDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn descriptionDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn lastChangedDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridView constrainedValuesECBLDataGridView;
    }
}