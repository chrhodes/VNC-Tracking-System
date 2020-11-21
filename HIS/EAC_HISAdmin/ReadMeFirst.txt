EAC Application Template ReadMe First
-------------------------------------
Once you have created a new solution using the EACApplicationTemplate{CSharp,VB} Visual Studio Template
there are a few things that need to be done to begin producing your solution.

1. Change the Startup Project to the TestWindowConsole
	Project/Properties/Debug - Start External Program

2. Paste the contents of TestWindowConsoleParameter.xml <AppConfigData> element into the TestWindowConsole parameter window.

3. Run the application, which will load the TestWindowConsole, and select the assembly that was built by clicking the Browse button

4. Verify basic functionality by loading one of the following UserControls by selecting it from the Object drop-down list.
	- ucApplicationMain
		NB. It is normal to receive an error "PopulateConfigValue. BackingVariable for Dog not Initialized".  This is to show what
		happens if the ConfigData.cs file needs to be modified to match the XML.

5. If you want to use PLLog for logging, search for NEWAPPNAME in the app.config file and update with the name of the application. 
	Work with Integration Services to ensure the appropriate <categorySource> is added to the app.config for EAC.exe.  You can modify the
	app.config for the TestWindowConsole during development time.