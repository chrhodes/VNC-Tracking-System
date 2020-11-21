namespace HIS_Tester
{
    partial class Form_HISItemDetail2
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
            this.btnLoadAttributeValues = new System.Windows.Forms.Button();
            this.txtItemId = new System.Windows.Forms.TextBox();
            this.lblTotalTime = new System.Windows.Forms.Label();
            this.lblItems = new System.Windows.Forms.Label();
            this.lblLoadHISSchema = new System.Windows.Forms.Label();
            this.attributeValuesECBLDataGridView = new System.Windows.Forms.DataGridView();
            this.btnLoadItems = new System.Windows.Forms.Button();
            this.dataGridViewTextBoxColumn5 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn6 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn7 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn8 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn9 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn10 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.attributeValuesECBLBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.itemsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.itemsDataGridView = new System.Windows.Forms.DataGridView();
            this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn4 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.attributeValuesECBLDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.attributeValuesECBLBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.itemsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.itemsDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // btnLoadAttributeValues
            // 
            this.btnLoadAttributeValues.Location = new System.Drawing.Point(247, 363);
            this.btnLoadAttributeValues.Name = "btnLoadAttributeValues";
            this.btnLoadAttributeValues.Size = new System.Drawing.Size(129, 23);
            this.btnLoadAttributeValues.TabIndex = 43;
            this.btnLoadAttributeValues.Text = "Load Attribute Values";
            this.btnLoadAttributeValues.UseVisualStyleBackColor = true;
            // 
            // txtItemId
            // 
            this.txtItemId.Location = new System.Drawing.Point(12, 365);
            this.txtItemId.Name = "txtItemId";
            this.txtItemId.Size = new System.Drawing.Size(220, 20);
            this.txtItemId.TabIndex = 42;
            // 
            // lblTotalTime
            // 
            this.lblTotalTime.AutoSize = true;
            this.lblTotalTime.Location = new System.Drawing.Point(431, 58);
            this.lblTotalTime.Name = "lblTotalTime";
            this.lblTotalTime.Size = new System.Drawing.Size(57, 13);
            this.lblTotalTime.TabIndex = 37;
            this.lblTotalTime.Text = "Total Time";
            // 
            // lblItems
            // 
            this.lblItems.AutoSize = true;
            this.lblItems.Location = new System.Drawing.Point(12, 84);
            this.lblItems.Name = "lblItems";
            this.lblItems.Size = new System.Drawing.Size(32, 13);
            this.lblItems.TabIndex = 41;
            this.lblItems.Text = "Items";
            // 
            // lblLoadHISSchema
            // 
            this.lblLoadHISSchema.AutoSize = true;
            this.lblLoadHISSchema.Location = new System.Drawing.Point(158, 58);
            this.lblLoadHISSchema.Name = "lblLoadHISSchema";
            this.lblLoadHISSchema.Size = new System.Drawing.Size(57, 13);
            this.lblLoadHISSchema.TabIndex = 36;
            this.lblLoadHISSchema.Text = "Total Time";
            // 
            // attributeValuesECBLDataGridView
            // 
            this.attributeValuesECBLDataGridView.AutoGenerateColumns = false;
            this.attributeValuesECBLDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.attributeValuesECBLDataGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dataGridViewTextBoxColumn5,
            this.dataGridViewTextBoxColumn6,
            this.dataGridViewTextBoxColumn7,
            this.dataGridViewTextBoxColumn8,
            this.dataGridViewTextBoxColumn9,
            this.dataGridViewTextBoxColumn10});
            this.attributeValuesECBLDataGridView.DataSource = this.attributeValuesECBLBindingSource;
            this.attributeValuesECBLDataGridView.Location = new System.Drawing.Point(12, 402);
            this.attributeValuesECBLDataGridView.Name = "attributeValuesECBLDataGridView";
            this.attributeValuesECBLDataGridView.Size = new System.Drawing.Size(1107, 327);
            this.attributeValuesECBLDataGridView.TabIndex = 40;
            // 
            // btnLoadItems
            // 
            this.btnLoadItems.Location = new System.Drawing.Point(12, 48);
            this.btnLoadItems.Name = "btnLoadItems";
            this.btnLoadItems.Size = new System.Drawing.Size(129, 23);
            this.btnLoadItems.TabIndex = 35;
            this.btnLoadItems.Text = "Load Items";
            this.btnLoadItems.UseVisualStyleBackColor = true;
            this.btnLoadItems.Click += new System.EventHandler(this.btnLoadItems_Click);
            // 
            // dataGridViewTextBoxColumn5
            // 
            this.dataGridViewTextBoxColumn5.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.dataGridViewTextBoxColumn5.DataPropertyName = "Id";
            this.dataGridViewTextBoxColumn5.HeaderText = "Id";
            this.dataGridViewTextBoxColumn5.Name = "dataGridViewTextBoxColumn5";
            this.dataGridViewTextBoxColumn5.Width = 41;
            // 
            // dataGridViewTextBoxColumn6
            // 
            this.dataGridViewTextBoxColumn6.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.dataGridViewTextBoxColumn6.DataPropertyName = "TableId";
            this.dataGridViewTextBoxColumn6.HeaderText = "TableId";
            this.dataGridViewTextBoxColumn6.Name = "dataGridViewTextBoxColumn6";
            this.dataGridViewTextBoxColumn6.Width = 68;
            // 
            // dataGridViewTextBoxColumn7
            // 
            this.dataGridViewTextBoxColumn7.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.dataGridViewTextBoxColumn7.DataPropertyName = "ItemId";
            this.dataGridViewTextBoxColumn7.HeaderText = "ItemId";
            this.dataGridViewTextBoxColumn7.Name = "dataGridViewTextBoxColumn7";
            this.dataGridViewTextBoxColumn7.Width = 61;
            // 
            // dataGridViewTextBoxColumn8
            // 
            this.dataGridViewTextBoxColumn8.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.dataGridViewTextBoxColumn8.DataPropertyName = "TypeAttributeId";
            this.dataGridViewTextBoxColumn8.HeaderText = "TypeAttributeId";
            this.dataGridViewTextBoxColumn8.Name = "dataGridViewTextBoxColumn8";
            this.dataGridViewTextBoxColumn8.Width = 104;
            // 
            // dataGridViewTextBoxColumn9
            // 
            this.dataGridViewTextBoxColumn9.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.dataGridViewTextBoxColumn9.DataPropertyName = "Value";
            this.dataGridViewTextBoxColumn9.HeaderText = "Value";
            this.dataGridViewTextBoxColumn9.Name = "dataGridViewTextBoxColumn9";
            this.dataGridViewTextBoxColumn9.Width = 59;
            // 
            // dataGridViewTextBoxColumn10
            // 
            this.dataGridViewTextBoxColumn10.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.dataGridViewTextBoxColumn10.DataPropertyName = "LastChanged";
            this.dataGridViewTextBoxColumn10.HeaderText = "LastChanged";
            this.dataGridViewTextBoxColumn10.Name = "dataGridViewTextBoxColumn10";
            this.dataGridViewTextBoxColumn10.Width = 95;
            // 
            // attributeValuesECBLBindingSource
            // 
            this.attributeValuesECBLBindingSource.DataSource = typeof(HIS.Library.AttributeValueEC);
            // 
            // itemsBindingSource
            // 
            this.itemsBindingSource.DataSource = typeof(HIS.Library.Item);
            // 
            // itemsDataGridView
            // 
            this.itemsDataGridView.AutoGenerateColumns = false;
            this.itemsDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.itemsDataGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dataGridViewTextBoxColumn1,
            this.dataGridViewTextBoxColumn2,
            this.dataGridViewTextBoxColumn3,
            this.dataGridViewTextBoxColumn4});
            this.itemsDataGridView.DataSource = this.itemsBindingSource;
            this.itemsDataGridView.Location = new System.Drawing.Point(15, 112);
            this.itemsDataGridView.Name = "itemsDataGridView";
            this.itemsDataGridView.Size = new System.Drawing.Size(665, 220);
            this.itemsDataGridView.TabIndex = 43;
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.DataPropertyName = "Id";
            this.dataGridViewTextBoxColumn1.HeaderText = "Id";
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            // 
            // dataGridViewTextBoxColumn2
            // 
            this.dataGridViewTextBoxColumn2.DataPropertyName = "TypeId";
            this.dataGridViewTextBoxColumn2.HeaderText = "TypeId";
            this.dataGridViewTextBoxColumn2.Name = "dataGridViewTextBoxColumn2";
            // 
            // dataGridViewTextBoxColumn3
            // 
            this.dataGridViewTextBoxColumn3.DataPropertyName = "Name";
            this.dataGridViewTextBoxColumn3.HeaderText = "Name";
            this.dataGridViewTextBoxColumn3.Name = "dataGridViewTextBoxColumn3";
            // 
            // dataGridViewTextBoxColumn4
            // 
            this.dataGridViewTextBoxColumn4.DataPropertyName = "LastChanged";
            this.dataGridViewTextBoxColumn4.HeaderText = "LastChanged";
            this.dataGridViewTextBoxColumn4.Name = "dataGridViewTextBoxColumn4";
            // 
            // Form_HISItemDetail2
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1139, 789);
            this.Controls.Add(this.itemsDataGridView);
            this.Controls.Add(this.btnLoadAttributeValues);
            this.Controls.Add(this.txtItemId);
            this.Controls.Add(this.lblTotalTime);
            this.Controls.Add(this.lblItems);
            this.Controls.Add(this.lblLoadHISSchema);
            this.Controls.Add(this.attributeValuesECBLDataGridView);
            this.Controls.Add(this.btnLoadItems);
            this.Name = "Form_HISItemDetail2";
            this.Text = "Form_HISItemDetail2";
            ((System.ComponentModel.ISupportInitialize)(this.attributeValuesECBLDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.attributeValuesECBLBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.itemsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.itemsDataGridView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnLoadAttributeValues;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn10;
        private System.Windows.Forms.TextBox txtItemId;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn9;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn8;
        private System.Windows.Forms.Label lblTotalTime;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn5;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn7;
        private System.Windows.Forms.Label lblItems;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn6;
        private System.Windows.Forms.Label lblLoadHISSchema;
        private System.Windows.Forms.BindingSource attributeValuesECBLBindingSource;
        private System.Windows.Forms.DataGridView attributeValuesECBLDataGridView;
        private System.Windows.Forms.Button btnLoadItems;
        private System.Windows.Forms.BindingSource itemsBindingSource;
        private System.Windows.Forms.DataGridView itemsDataGridView;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn2;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn3;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn4;
    }
}