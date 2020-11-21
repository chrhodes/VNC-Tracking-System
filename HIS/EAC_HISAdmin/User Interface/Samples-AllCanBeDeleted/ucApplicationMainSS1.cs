﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Windows.Forms;

namespace EAC_HISAdmin.User_Interface
{
    public partial class ucApplicationMainSS1 : ucScreenBase
    {
        const string CONTROL_NAME = "ucApplicationMainSS1";

        #region Initialization

        public ucApplicationMainSS1()
        {
#if TRACE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
            InitializeComponent();
        }

        /// <summary>
        /// Perform any initialization that is wanted before much else happens.
        /// By now the controls should be present and ready to go.  This method
        /// typically does not need to change.
        /// </summary>
        public override void InitialLoad()
        {
#if TRACE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
            // Load another instance of this control back into the Controls collection
            // so the control can be swapped in and out. Do not delete this line.
            base.ShowControl(this.GetType());

            // Perform any initialization that is needed.
            InitializeUI();
        }

        /// <summary>
        /// Initialize the UI.  This is called from InitialLoad and has been pulled out into a separate
        /// method in case it needs to be called again.  
        /// 
        /// Typically this method changes depending on the needs of the application.
        /// 
        /// Also see the BeforeSwappingOut and AfterSwappingIn methods.
        /// </summary>
        public override void InitializeUI()
        {
#if TRACE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
            // TODO: Load up combo boxes, initialize data, etc.

            #region Template Sample

            Type me = this.GetType();
            StringBuilder sb = new StringBuilder();
            Type baseType = me;

            do
            {
                sb.AppendFormat("{0}:", baseType.Name);
                baseType = baseType.BaseType;
            } while (baseType.Name != "UserControl");

            sb.AppendFormat("UserControl");

            label1.Text = sb.ToString();

            #endregion

        }

        #endregion

        #region ApplicationLevel Event Handlers

        /// <summary>
        /// Initialize the Application Level Event Handlers.
        /// 
        /// Typically this does not need to change unless the events are not desired
        /// or more events need to be added.
        /// </summary>
        protected override void InitializeApplicationEventHandlers()
        {
#if TRACE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
            ApplicationEventHandler.ToggleF11Event += this.ToggleDebugMode;
            ApplicationEventHandler.ToggleF12Event += this.ToggleDeveloperMode;
        }

        /// <summary>
        /// Perform any operations that are needed when DebugMode switches state.
        /// </summary>
        protected override void ToggleDebugMode()
        {
#if TRACE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif

            Common.DebugMode = !Common.DebugMode;

            if (Common.DebugMode)
            {
                // TODO:
            }
            else
            {
                // TODO:
            }
        }

        /// <summary>
        /// Perform any operations that are needed when DeveloperMode switches state.
        /// </summary>
        protected override void ToggleDeveloperMode()
        {
#if TRACE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif

            Common.DeveloperMode = !Common.DeveloperMode;

            if (Common.DeveloperMode)
            {
                this.BackColor = Color.LightSeaGreen;
                Common.DebugWindow.Show();
            }
            else
            {
                this.BackColor = SystemColors.ControlLight;
                Common.DebugWindow.Hide();
            }
        }

        /// <summary>
        /// Remove the Application Level Event Handlers.
        /// 
        /// Typically this does not need to change unless the events are not desired
        /// or more events need to be added.
        /// </summary>
        protected override void RemoveApplicationEventHandlers()
        {
#if TRACE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
            ApplicationEventHandler.ToggleF11Event -= this.ToggleDebugMode;
            ApplicationEventHandler.ToggleF12Event -= this.ToggleDeveloperMode;
        }

        #endregion

        #region Swapping Methods

        /// These methods may be commented out if not used.
        /// 
        /// <summary>
        /// Perform any operations before the screen is swapped out.
        /// </summary>
        protected override void BeforeSwappingOut()
        {
#if TRACE_BASE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
        }

        /// <summary>
        /// Perform any operations after the screen is swapped in.
        /// </summary>
        protected override void AfterSwappingIn()
        {
#if TRACE_BASE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
        }

        #endregion

        #region Event Handlers

        #region Template Sample

        private void btnGotoApplicationMain_Click(object sender, EventArgs e)
        {
            GoToApplicationMain();
        }

        private void btnGoToSS2_Click(object sender, EventArgs e)
        {
            GoToSS2();
        }

        private void btnReturnToSender_Click(object sender, EventArgs e)
        {
            ReturnToSender();
        }

        #endregion

        private void btnInfo_Click(object sender, EventArgs e)
        {
            DisplayAssemblyInfo();
        }

        #endregion

        #region Main Function Routines

        #region Template Sample

        private void GoToApplicationMain()
        {
            SwapUserControl(this, System.Type.GetType("EAC_HISAdmin.User_Interface.ucApplicationMain"));
        }

        private void GoToSS2()
        {
#if TRACE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
            // Why can't this be done?
            //SwapUserControl(this, ucSearchDetail3);
            SwapUserControl(this, System.Type.GetType("EAC_HISAdmin.User_Interface.ucApplicationMainSS2"));
        }

        #endregion

        private void DisplayAssemblyInfo()
        {
            Assembly asmb = Assembly.GetExecutingAssembly();
            AssemblyHelper.AssemblyInformation info = new AssemblyHelper.AssemblyInformation(asmb);
            MessageBox.Show(info.ToString(), "Assembly Information");
        }

        #endregion

    }
}
