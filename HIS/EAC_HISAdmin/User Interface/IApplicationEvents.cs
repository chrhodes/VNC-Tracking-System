using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EAC_HISAdmin.User_Interface
{
    interface IApplicationEvents
    {
        //void InitializeApplicationEventHandlers;
        event EventHandler ToggleDebugMode;
        event EventHandler ToggleDeveloperMode;
        //void RemoveApplicationEventHandlers;
    }
}
