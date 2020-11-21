﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using EAC_HISAdmin.User_Interface;

namespace EAC_HISAdmin
{
    ///<summary>
    ///Common items declared at the Class level.
    ///</summary>
    ///<remarks>
    ///Use this class for any thing you want globally available.
    ///Place only Static items in this class.  This Class cannot not be instantiated.
    ///</remarks>    
    public static class Common
    {
        const string CONTROL_NAME = "Common";

        public static void Initialize()
        {
#if TRACE_BASE
            Common.WriteToDebugWindow(string.Format("{0}:{1}()", CONTROL_NAME, System.Reflection.MethodInfo.GetCurrentMethod().Name));
#endif
            SwapScreenBaseControl = null;
            InitializedUserControls = null;

            // TODO: Add code to (re)Initialize anything that needs to start clear
            // when ucBase.Reload() is called.

        }

        #region Core

        public static ucScreenBase SwapScreenBaseControl
        {
            get;
            set;
        }

        /// <summary>
        ///  This property holds a keyed reference to each instantiated swappable user control.
        ///  The ucSwapScreenBase loads the control into it's Controls collection to display
        ///  the screen.  Maintaining the controls in a static Dictionary allows state to be maintained.
        /// </summary>
        private static Dictionary<string, ucScreenBase> _InitializedUserControls;
        public static Dictionary<string, ucScreenBase> InitializedUserControls
        {
            get
            {
                if (_InitializedUserControls == null)
                {
                    _InitializedUserControls = new Dictionary<string, ucScreenBase>();
                }

                return _InitializedUserControls;
            }
            set
            {
                _InitializedUserControls = value;
            }
        }

        // TODO: Add as many DebugLevels as needed.
        // Add accompanying checkboxes on frmDebugWindow

        public static bool DebugLevel1
        {
            get;
            set;
        }
        public static bool DebugLevel2
        {
            get;
            set;
        }
        public static bool DebugSQL
        {
            get;
            set;
        }

        /// <summary>
        /// Indicates whether the UI is running in DeveloperMode
        /// </summary>
        public static bool DeveloperMode
        {
            get;
            set;
        }
        /// <summary>
        /// Indicates whether the UI is running in DebugMode
        /// </summary>
        public static bool DebugMode
        {
            get;
            set;
        }

        private static User_Interface.frmDebugWindow _debugWindow;

        public static User_Interface.frmDebugWindow DebugWindow
        {
            get
            {
                if (_debugWindow == null)
                {
                    _debugWindow = new User_Interface.frmDebugWindow();
                }
                return _debugWindow;
            }
            set
            {
                _debugWindow = value;
            }
        }

        public static void WriteToDebugWindow(string message)
        {
            User_Interface.frmDebugWindow frm = DebugWindow;
            frm.txtOutput.AppendText(Environment.NewLine);
            frm.txtOutput.AppendText(message);
        }

        #endregion

        private static Data.ApplicationDataSet _ApplicationDS;
        public static Data.ApplicationDataSet ApplicationDS
        {
            get
            {
                if (_ApplicationDS == null)
                {
                    _ApplicationDS = new Data.ApplicationDataSet();

                    // TODO: Add any other initialization of things related to the ApplicationDS
                }

                return _ApplicationDS;
            }
            set
            {
                _ApplicationDS = value;
            }
        }
    }
}
