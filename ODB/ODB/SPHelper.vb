Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.Navigation
Imports PacificLife.Life
Imports System.Collections
Imports System.Collections.Specialized
Imports System.Xml

''' <summary>
''' General purpose SharePoint helper methods.  Contains an embedded class, Provision, 
''' that supports processing of elememts from provisioning XML file.
''' </summary>
''' <remarks>TODO: Decide if generic helper methods should be grouped with SPHelper.Provision methods or kept separate</remarks>

Public Class SPHelper

    Public Enum RoleInheritance As Byte
        CopyFromParent = True
        DoNotCopyFromParent = False
    End Enum

    Public Enum RoleAssignments As Byte
        Keep = True
        Remove = False
    End Enum

#Region "General Purpose Methods"

#Region "List Creation methods"

    Public Shared Sub AddList(ByVal web As SPWeb, ByVal title As String, ByVal description As String, ByVal listTemplateType As SPListTemplateType, ByVal enableVersioning As Boolean)
        PLLog.Trace("Enter Method", "OnTrac")
       
        Try
            web.Lists.Add(title, description, listTemplateType)
            Dim newList As SPList = web.Lists(title)
            newList.EnableVersioning = enableVersioning
            newList.Update()
        Catch ex As SPException
            If ex.Message.ToString().Contains("The specified name is already in use.") Then
                'The list name already exists, log the error but do not raise exception again
                PLLog.Error("The list " + title + " already exists in current web site", "OnTrac")
            Else
                Throw ex
            End If
        End Try

        PLLog.Trace("Exit Method", "OnTrac")
    End Sub

#End Region

#Region "Role Assignment methods"

    ' These methods are used to grant access to various things.  Most common is granting a user access to the web (site).
    ' Verify the user(s)/group(s) already have been added and that permissionLevels (roleDefinitions) have been established.
    ' Note: These methods and the arguments passed have been named to follow the object model more closely, e.g.
    ' SPRoleDefinition is PermissionLevel in the UI.



#Region "Web Role Assignments"

    Public Shared Sub AddRoleAssignment(ByVal web As SPWeb, ByVal roleDefinition As SPRoleDefinition, ByVal users As List(Of SPUser))
        For Each user As SPUser In users
            AddRoleAssignment(web, roleDefinition, DirectCast(user, SPPrincipal))
        Next
    End Sub

    Public Shared Sub AddRoleAssignment(ByVal web As SPWeb, ByVal roleDefinition As SPRoleDefinition, ByVal user As SPUser)
        AddRoleAssignment(web, roleDefinition, DirectCast(user, SPPrincipal))
    End Sub

    Public Shared Sub AddRoleAssignment(ByVal web As SPWeb, ByVal roleDefinition As SPRoleDefinition, ByVal group As SPGroup)
        AddRoleAssignment(web, roleDefinition, DirectCast(group, SPPrincipal))
    End Sub

    Public Shared Sub AddRoleAssignment(ByVal web As SPWeb, ByVal roleDefinition As SPRoleDefinition, ByVal principal As SPPrincipal)
        Dim startTicks As Long
        startTicks = PLLog.Trace("Enter Method", "OnTrac")

        Dim roleAssignment As SPRoleAssignment = New SPRoleAssignment(principal)

        roleAssignment.RoleDefinitionBindings.Add(roleDefinition)
        web.RoleAssignments.Add(roleAssignment)
        web.Update()

        PLLog.Trace("Exit Method", "OnTrac", startTicks)
    End Sub

    Public Shared Sub RemoveAllRoleAssignments(ByVal web As SPWeb)
        web.ResetRoleInheritance()
        web.BreakRoleInheritance(RoleInheritance.DoNotCopyFromParent)
        web.Update()
    End Sub
#End Region

#Region "List Role Assignments"

    Public Shared Sub AddRoleAssignment(ByVal list As SPList, ByVal roleDefinition As SPRoleDefinition, ByVal users As List(Of SPUser))
        For Each user As SPUser In users
            AddRoleAssignment(List, roleDefinition, DirectCast(user, SPPrincipal))
        Next
    End Sub

    Public Shared Sub AddRoleAssignment(ByVal list As SPList, ByVal roleDefinition As SPRoleDefinition, ByVal user As SPUser)
        AddRoleAssignment(list, roleDefinition, DirectCast(user, SPPrincipal))
    End Sub

    Public Shared Sub AddRoleAssignment(ByVal list As SPList, ByVal roleDefinition As SPRoleDefinition, ByVal group As SPGroup)
        AddRoleAssignment(list, roleDefinition, DirectCast(group, SPPrincipal))
    End Sub

    Public Shared Sub AddRoleAssignment(ByVal list As SPList, ByVal roleDefinition As SPRoleDefinition, ByVal principal As SPPrincipal)
        Dim startTicks As Long
        startTicks = PLLog.Trace("Enter Method", "OnTrac")

        Dim roleAssignment As SPRoleAssignment = New SPRoleAssignment(principal)

        roleAssignment.RoleDefinitionBindings.Add(roleDefinition)
        list.RoleAssignments.Add(roleAssignment)
        list.Update()

        PLLog.Trace("Exit Method", "OnTrac", startTicks)
    End Sub

    Public Shared Sub RemoveAllRoleAssignments(ByVal list As SPList)
        list.ResetRoleInheritance()
        list.BreakRoleInheritance(RoleInheritance.DoNotCopyFromParent)
        list.Update()
    End Sub

#End Region

#End Region

#Region "Role Definition methods"
    ' Methods used to interact with RoleDefinitions(Permission Levels)

    ''' <summary>
    ''' Adds a RoleDefintion(PermissionLevel) to web
    ''' </summary>
    ''' <param name="Name"></param>
    ''' <param name="ExistingPermissionLevel"></param>
    ''' <param name="Description"></param>
    ''' <param name="Order"></param>
    ''' <param name="Web"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    ''' 

    Public Shared Function AddRoleDefinitionToWeb(ByVal Name As String, ByVal Description As String, ByVal Order As Integer, ByVal ExistingPermissionLevel As String, ByVal Web As SPWeb) As SPRoleDefinition

        PLLog.Trace("Enter Method Name:>" & Name & "< Web:>" & Web.Name & "<", "OnTrac")

        ' If the RoleDefinition does not exist create it

        If Not RoleDefinitionExists(Name, Web) Then
            Dim roleDef As SPRoleDefinition = New SPRoleDefinition()
            Dim permMask As SPBasePermissions

            If Not RoleDefinitionExists(ExistingPermissionLevel, Web) Then
                Throw New ApplicationException("ExistingPermissionLevel:>" & ExistingPermissionLevel & "< does not exist.  Check Provisioning XML file")
            End If

            permMask = Web.RoleDefinitions(ExistingPermissionLevel).BasePermissions()

            With roleDef
                .Name = Name
                .BasePermissions = permMask
                .Description = Description
                .Order = Order
            End With

            Web.AllowUnsafeUpdates = True
            Web.RoleDefinitions.Add(roleDef)

            PLLog.Trace("Exit Method", "OnTrac")

            Return Web.RoleDefinitions(Name)
        End If

        Return Web.RoleDefinitions(Name)

    End Function

    ''' <summary>
    ''' Adds a RoleDefinition(PermissionLevel)
    ''' </summary>
    ''' <param name="Name"></param>
    ''' <param name="PermissionMask"></param>
    ''' <param name="Description"></param>
    ''' <param name="Order"></param>
    ''' <param name="Web"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Public Shared Function AddRoleDefinitionToWeb(ByVal Name As String, ByVal Description As String, ByVal Order As Integer, ByVal PermissionMask As SPBasePermissions, ByVal Web As SPWeb) As SPRoleDefinition

        PLLog.Trace("Enter Method Name:>" & Name & "< Web:>" & Web.Name & "<", "OnTrac")

        Dim roleDef As SPRoleDefinition = New SPRoleDefinition()

        With roleDef
            .Name = Name
            .BasePermissions = PermissionMask
            .Description = Description
            .Order = Order
        End With

        Web.AllowUnsafeUpdates = True
        Web.RoleDefinitions.Add(roleDef)

        PLLog.Trace("Exit Method", "OnTrac")

        Return Web.RoleDefinitions(Name)
    End Function

    Public Shared Function RoleDefinitionExists(ByVal name As String, ByVal web As SPWeb) As Boolean
        For Each permissionLevel As SPRoleDefinition In web.RoleDefinitions
            If permissionLevel.Name.ToLower = name.ToLower Then
                Return True
            End If
        Next

        Return False
    End Function

    ''' <summary>
    ''' Return a Role given its name or Nothing if not found.
    ''' Note: Roles are called Permission Levels in the SharePoint UI
    ''' </summary>
    ''' <param name="web"></param>
    ''' <param name="roleName">Name of role to find</param>
    ''' <returns>SPRoleDefinition or Nothing</returns>
    ''' <remarks></remarks>

    Public Shared Function GetRole(ByVal web As SPWeb, ByVal roleName As String) As SPRoleDefinition
        'PrintRoles(web)

        For Each role As SPRoleDefinition In web.RoleDefinitions
            If (role.Name.ToLower = roleName.ToLower) Then
                Return role
            End If
        Next

        Return Nothing
    End Function

#End Region

    ''' <summary>
    ''' Returns list of items matching query
    ''' </summary>
    ''' <param name="list"></param>
    ''' <param name="queryText"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Public Shared Function GetItems(ByVal list As SPList, ByVal queryText As String) As SPListItemCollection

        PLLog.Trace("Enter Method list:>" & list.Title & "< queryText:>" & queryText & "<", "OnTrac")

        Dim query As SPQuery = New SPQuery()
        query.Query = queryText

        PLLog.Trace("Exit Method", "OnTrac")

        Return list.GetItems(query)

    End Function

    ''' <summary>
    ''' Gets list by name from current site
    ''' </summary>
    ''' <param name="listName"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Public Shared Function GetList(ByVal listName) As SPList

        Return SPContext.Current.Web.Lists(listName)

    End Function

    ''' <summary>
    ''' Gets list by name from specified site
    ''' </summary>
    ''' <param name="web"></param>
    ''' <param name="listName"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Public Shared Function GetList(ByVal web As SPWeb, ByVal listName As String) As SPList

        Return web.Lists(listName)

    End Function

    ''' <summary>
    ''' Gets group by name from site
    ''' </summary>
    ''' <param name="web"></param>
    ''' <param name="groupName"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Public Shared Function GetSiteGroup(ByVal web As SPWeb, ByVal groupName As String) As SPGroup
        For Each group As SPGroup In web.SiteGroups
            If (group.Name.ToLower = groupName.ToLower) Then
                Return group
            End If
        Next

        Return Nothing
    End Function

    ''' <summary>
    ''' Gets fields for view on specified list
    ''' </summary>
    ''' <param name="list"></param>
    ''' <param name="viewName"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Public Shared Function GetViewFields(ByVal list As SPList, ByVal viewName As String) As SPViewFieldCollection

        PLLog.Trace("Enter Method list:>" & list.Title & "< viewName:>" & viewName & "<", "OnTrac")

        PLLog.Trace("Exit Method", "OnTrac")

        Return list.Views(viewName).ViewFields

    End Function

    ''' <summary>
    ''' Removes all users from specified group
    ''' </summary>
    ''' <param name="group"></param>
    ''' <remarks></remarks>

    Shared Sub RemoveAllUsers(ByVal group As SPGroup)

        PLLog.Trace("Enter Method group:>" & group.Name & "<", "OnTrac")

        For index As Integer = 0 To group.Users.Count - 1
            group.Users.Remove(index)
        Next

        PLLog.Trace("Exit Method", "OnTrac")

    End Sub

#Region "Token replacement routines"

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="inStr"></param>
    ''' <param name="WebId"></param>
    ''' <param name="ListId"></param>
    ''' <param name="NewId"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Shared Function ReplaceTokens(ByVal inStr As String, ByVal WebId As String, ByVal ListId As String, ByVal NewId As String) As String
        Dim worker As String = inStr
        worker = worker.Replace("{WEB_ID}", WebId)
        worker = worker.Replace("{LIST_ID}", ListId)
        worker = worker.Replace("{NEW_GUID}", NewId)
        Return worker
    End Function

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="inStr"></param>
    ''' <param name="Web"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Shared Function ReplaceTokens(ByVal inStr As String, ByVal Web As SPWeb) As String
        Dim worker As String = inStr
        worker = worker.Replace("~site", Web.Site.Url)
        worker = worker.Replace("~web", Web.Url)
        Return worker
    End Function

#End Region

    ' TODO: This routine does not appear to be used.  Verify there is a method to add a user to the web taking the passed parameters
    ' Then call the AddRoleAssignment() methods.

    ''' <summary>
    ''' Add user to web
    ''' </summary>
    ''' <param name="Login"></param>
    ''' <param name="Email"></param>
    ''' <param name="Name"></param>
    ''' <param name="Notes"></param>
    ''' <param name="Role"></param>
    ''' <param name="Web"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    Public Shared Function AddUserToWeb(ByVal Login As String, ByVal Email As String, ByVal Name As String, ByVal Notes As String, ByVal Role As SPRoleDefinition, ByVal Web As SPWeb) As SPUser
        Dim roleAssignment As New SPRoleAssignment(Login, Email, Name, Notes)
        roleAssignment.RoleDefinitionBindings.Add(Role)
        Web.RoleAssignments.Add(roleAssignment)
        Return Web.Users(Login)
    End Function

#Region "Routines to make things Read Only"

    ''' <summary>
    ''' Makes specified web read only
    ''' </summary>
    ''' <param name="web"></param>
    ''' <remarks></remarks>

    Public Shared Sub SetReadOnly(ByVal web As SPWeb)
        Dim startTicks As Long
        startTicks = PLLog.Trace("Enter Method", "OnTrac")

        Try

            web.AllowUnsafeUpdates = True
            If Not web.HasUniqueRoleAssignments Then
                web.BreakRoleInheritance(False)
                web.BreakRoleInheritance(RoleInheritance.DoNotCopyFromParent)
            End If
            ' remove all permissions
            For Each ra As SPRoleAssignment In web.RoleAssignments
                ra.RoleDefinitionBindings.RemoveAll()
                ra.Update()
            Next

            Dim read As SPRoleDefinition = web.RoleDefinitions.Item("Read")
            ' add read permissions
            For Each user As SPUser In web.Users
                Dim r As New SPRoleAssignment(user)
                r.RoleDefinitionBindings.Add(read)
                web.RoleAssignments.Add(r)
            Next
            web.Update()

            PLLog.Trace("Exit Method", "OnTrac")

        Catch ex As Exception

            PLLog.Error(ex, "OnTrac")
            PLLog.Trace("Exit MethodEX", "OnTrac", startTicks)

            Throw ex

        End Try
    End Sub

    ''' <summary>
    ''' Makes specified list read only
    ''' </summary>
    ''' <param name="list"></param>
    ''' <remarks></remarks>

    Public Shared Sub SetReadOnly(ByVal list As SPList)

        PLLog.Trace("Enter Method", "OnTrac")

        Try

            Dim web As SPWeb = list.ParentWeb

            If Not list.HasUniqueRoleAssignments Then
                'list.BreakRoleInheritance(False)
                list.BreakRoleInheritance(RoleInheritance.DoNotCopyFromParent)
            End If
            ' remove all permissions
            For Each ra As SPRoleAssignment In list.RoleAssignments
                ra.RoleDefinitionBindings.RemoveAll()
                ra.Update()
            Next

            Dim read As SPRoleDefinition = web.RoleDefinitions.Item("Read")
            ' add read permissions
            For Each user As SPUser In web.Users
                Dim r As New SPRoleAssignment(user)
                r.RoleDefinitionBindings.Add(read)
                list.RoleAssignments.Add(r)
            Next
            web.Update()

            PLLog.Trace("Exit Method", "OnTrac")

        Catch ex As Exception

            PLLog.Error(ex, "OnTrac")
            PLLog.Trace("Exit MethodEX", "OnTrac")

            Throw ex

        End Try

    End Sub

    ''' <summary>
    ''' Makes specified list read only
    ''' </summary>
    ''' <param name="item"></param>
    ''' <remarks></remarks>

    Public Shared Sub SetReadOnly(ByVal item As SPListItem)
        'TODO: This routine was empty.  Is that right?
    End Sub

#End Region

#End Region

#Region "Provisioning XML Methods"
    ''' <summary>
    ''' Contains methods to process sections defined in provisioning XML files
    ''' Also contains some general purpose routines that support the provisioning process 
    ''' but have general purpose use.  Need to decide if should pull these dual purpose
    ''' routines out.
    ''' 
    ''' These methods are called by the class that implements the SPWebProvisioningProvider interface.  
    ''' See WorkCenterProvisioningProvider.vb - Provision()
    ''' </summary>
    ''' <remarks></remarks>

    Public Class Provision

        ''' <summary>
        ''' Process the provisioning XML file and add any elements defined there.
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>
        Public Shared Sub ProcessProvisioningXMLFile(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Try
                ' TODO: Determine which order things should be called in.
                ' Probably create stuff then secure stuff.

                SPHelper.Provision.ProcessGroups(web, doc)

                SPHelper.Provision.ProcessFields(web, doc)

                SPHelper.Provision.ProcessFieldLinks(web, doc)

                SPHelper.Provision.ProcessLists(web, doc)

                SPHelper.Provision.ProcessViews(web, doc)

                SPHelper.Provision.ProcessQuickLaunch(web, doc)

                'Commented out by Neudesic originally.
                'CreateTopNavigation(web, doc)
                'SPHelper.Provision.ProcessTopNavigation(web, doc)

                SPHelper.Provision.ProcessPermissionLevels(web, doc)

                SPHelper.Provision.ProcessRoleAssignments(web, doc)

            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                Throw ex
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

#Region "Fields elements from XML file"
        ' These methods are used to create fields

        ''' <summary>
        ''' Create Fields from Provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>
        ''' 

        Public Shared Sub ProcessFields(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = "" 'rfs11/07

            Try
                Dim postProcessing As XmlNode = doc.DocumentElement.SelectSingleNode("//Fields")

                For Each node As XmlNode In postProcessing.ChildNodes
                    nodeName = node.Name.ToString

                    If node.Name = "AddLookupAsXml" Then
                        Dim lookupList As String = node.Attributes("LookupList").Value

                        PLLog.Debug("AddLookupAsXml: lookupList:>" & lookupList, "OnTrac")

                        Dim List As SPList = SPHelper.GetList(web, lookupList)

                        web.Fields.AddFieldAsXml( _
                            ReplaceTokens(node.InnerXml, _
                            web.ID.ToString(), _
                            List.ID.ToString(), _
                            System.Guid.NewGuid.ToString()))
                    End If
                Next
            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing Fields Node: >" & nodeName & "< Check Provisioning XML file.", ex)
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

#End Region

#Region "Field Links elements from XML file"

        ''' <summary>
        ''' Create FieldLinks from Provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>

        Public Shared Sub ProcessFieldLinks(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = ""

            Try
                Dim fieldLinks As XmlNode = doc.DocumentElement.SelectSingleNode("//FieldLinks")

                For Each node As XmlNode In fieldLinks.ChildNodes
                    nodeName = node.Name.ToString

                    If node.Name = "AddFieldLink" Then
                        Dim contentTypeId As String = node.Attributes("ContentTypeId").Value
                        Dim fieldName As String = node.Attributes("FieldName").Value

                        PLLog.Debug("AddFieldLink: contentTypeId:>" & contentTypeId & "< fieldName:>" & fieldName & "<", "OnTrac")

                        Dim ct As SPContentType = web.ContentTypes(New SPContentTypeId(contentTypeId))
                        Dim fl As SPFieldLink = New SPFieldLink(web.Fields(fieldName))

                        ct.FieldLinks.Add(fl)
                        ct.Update(True)
                    End If
                Next
            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing FieldLinks Node: >" & nodeName & "< Check Provisioning XML file.", ex)
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

#End Region

        ' TODO: Remove this code.
#Region "Add Final Library elements from XML file"


        ' 1/24/2008 crhodes.  SPHelper should be for generic things, not things specific to OnTrac.
        ' So, lets not do this here.  I will add support for adding lists to sites using the XML files
        ' on 1/24/2008

        'Public Shared Sub ProcessAddFinalLibrary(ByVal web As SPWeb, ByVal doc As XmlDocument)

        '    PLLog.Trace("Enter Method", "OnTrac")

        '    Dim nodeName As String = "" 'rfs11/07

        '    Try
        '        'Dim views As XmlNode = doc.DocumentElement.SelectSingleNode("//QuickLaunch")

        '        web.Lists.Add("Final Library", "This is where the final version of material resides", SPListTemplateType.DocumentLibrary)

        '        'web.Update()
        '    Catch ex As Exception
        '        PLLog.Error("Error Processing Add Final Library Node: >" & nodeName & "<. Check Provisioning XML file.", "OnTrac") 'rfs11/07
        '        PLLog.Error(ex, "OnTrac")
        '        PLLog.Trace("Exit MethodEX", "OnTrac")

        '        Dim exNew As New ApplicationException("Error Processing Add Final Library Node: >" & nodeName & "< Check Provisioning XML file.", ex) 'rfs11/07
        '        Throw exNew
        '    End Try

        '    PLLog.Trace("Exit Method", "OnTrac")

        'End Sub

#End Region

#Region "Lists elements from XML file"
        ' These methods are used to interact with lists

        ''' <summary>
        ''' Add Lists from provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>

        Public Shared Sub ProcessLists(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = ""

            Try
                Dim lists As XmlNode = doc.DocumentElement.SelectSingleNode("//Lists")

                For Each node As XmlNode In lists.ChildNodes
                    nodeName = node.Name.ToString

                    If nodeName <> "List" Then
                        PLLog.Error("Only <List> elements may be contained in <Lists></Lists>", "OnTrac")
                    Else
                        Dim title As String = node.Attributes("Title").Value
                        Dim description As String = node.Attributes("Description").Value
                        Dim listTemplate As String = node.Attributes("ListTemplate").Value
                        Dim listTemplateType As String = node.Attributes("ListTemplateType").Value
                        Dim documentTemplate As String = node.Attributes("DocumentTemplate").Value
                        Dim documentTemplateType As String = node.Attributes("DocumentTemplateType").Value
                        Dim enableVersioning As Boolean = True
                        Boolean.TryParse(node.Attributes("EnableVersioning").Value, enableVersioning)
                        Dim featureId As String = node.Attributes("FeatureID").Value
                        Dim url As String = node.Attributes("Url").Value

                        ' TODO: Process above attribute variables and call code to add things.
                        ' For now we just support the ListTemplateType argument.  Update the error
                        ' message as more support is added.

                        If (listTemplate.Length > 0 Or _
                            documentTemplate.Length > 0 Or _
                            documentTemplateType.Length > 0 Or _
                            featureId.Length > 0 Or url.Length > 0) Then
                            PLLog.Error("ListTemplate, DocumentTemplate, DocumentTemplateType, FeatureID, Url are not currently supported attributes.  Ignoring", "OnTrac")
                        End If

                        If listTemplateType.Length > 0 Then
                            Dim templateType As SPListTemplateType = Provision.GetListTemplateTypeByName(listTemplateType)

                            If templateType <> SPListTemplateType.InvalidType Then
                                AddList(web, title, description, templateType, enableVersioning)
                            Else
                                PLLog.Error("Invalid ListTemplateType", "OnTrac")
                            End If
                        End If

                    End If
                Next
            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing Lists Node: >" & nodeName & "< Check Provisioning XML file.", ex)
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

        Private Shared Function GetListTemplateTypeByName(ByVal listTemplateType As String) As SPListTemplateType
            Dim result As SPListTemplateType = SPListTemplateType.InvalidType

            Select Case listTemplateType.ToString.ToUpper
                Case "ADMINTASKS"
                    result = SPListTemplateType.AdminTasks

                Case "AGENDA"
                    result = SPListTemplateType.Agenda

                Case "ANNOUNCEMENTS"
                    result = SPListTemplateType.Announcements

                Case "CATEGORIES"
                    result = SPListTemplateType.Categories

                Case "COMMENTS"
                    result = SPListTemplateType.Comments

                Case "CONTACTS"
                    result = SPListTemplateType.Contacts

                Case "CUSTOMGRID"
                    result = SPListTemplateType.CustomGrid

                Case "DATACONNECTIONLIBRARY"
                    result = SPListTemplateType.DataConnectionLibrary

                Case "DATASOURCES"
                    result = SPListTemplateType.DataSources

                Case "DECISION"
                    result = SPListTemplateType.Decision

                Case "DISCUSSIONBOARD"
                    result = SPListTemplateType.DiscussionBoard

                Case "DOCUMENTLIBRARY"
                    result = SPListTemplateType.DocumentLibrary

                Case "EVENTS"
                    result = SPListTemplateType.Events

                Case "GANTTTASKS"
                    result = SPListTemplateType.GanttTasks

                Case "GENERICLIST"
                    result = SPListTemplateType.GenericList

                Case "HOMEPAGELIBRARY"
                    result = SPListTemplateType.HomePageLibrary

                Case "ISSUETRACKING"
                    result = SPListTemplateType.IssueTracking

                Case "LINKS"
                    result = SPListTemplateType.Links

                Case "LISTTEMPLATECATALOG"
                    result = SPListTemplateType.ListTemplateCatalog

                Case "MEETINGOBJECTIVE"
                    result = SPListTemplateType.MeetingObjective

                Case "MEETINGS"
                    result = SPListTemplateType.Meetings

                Case "MEETINGUSER"
                    result = SPListTemplateType.MeetingUser

                Case "NOCODEWORKFLOWS"
                    result = SPListTemplateType.NoCodeWorkflows

                Case "PICTURELIBRARY"
                    result = SPListTemplateType.PictureLibrary

                Case "POSTS"
                    result = SPListTemplateType.Posts

                Case "SURVEY"
                    result = SPListTemplateType.Survey

                Case "TASKS"
                    result = SPListTemplateType.Tasks

                Case "TEXTBOX"
                    result = SPListTemplateType.TextBox

                Case "THINGSTOBRING"
                    result = SPListTemplateType.ThingsToBring

                Case "USERINFORMATION"
                    result = SPListTemplateType.UserInformation

                Case "WEBPAGELIBRARY"
                    result = SPListTemplateType.WebPageLibrary

                Case "WEBPARTCATALOG"
                    result = SPListTemplateType.WebPartCatalog

                Case "WEBTEMPLATECATALOG"
                    result = SPListTemplateType.WebTemplateCatalog

                Case "WORKFLOWHISTORY"
                    result = SPListTemplateType.WorkflowHistory

                Case "WORKFLOWPROCESS"
                    result = SPListTemplateType.WorkflowProcess

                Case "XMLFORM"
                    result = SPListTemplateType.XMLForm

                Case Else
                    ' Probably don't want to throw an exception.  Just return invalid type.
                    'Throw New ApplicationException("Invalid ListTemplateType:>" & listTemplateType & "< check Provisioning XML file")
            End Select

            Return result
        End Function

#End Region

#Region "Quick Launch elements from XML file"
        ' These methods are used to interact with the Quick Launch bar

        ''' <summary>
        ''' Create Quick Launch from provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>

        Public Shared Sub ProcessQuickLaunch(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = "" 'rfs11/07

            Try
                Dim views As XmlNode = doc.DocumentElement.SelectSingleNode("//QuickLaunch")
                Dim keys As New Dictionary(Of String, SPNavigationNode)

                For Each node As XmlNode In views.ChildNodes
                    nodeName = node.Name.ToString

                    Dim parent As String = node.Attributes("Parent").Value
                    Dim id As String = node.Attributes("Id").Value

                    Dim parentNode As SPNavigationNode
                    Dim lnk As SPNavigationNode

                    lnk = New SPNavigationNode(node.Attributes("Text").Value, ReplaceTokens(node.Attributes("Url").Value, web), Boolean.Parse(node.Attributes("External").Value))

                    If parent <> String.Empty Then
                        Try
                            parentNode = keys(parent)
                        Catch ex As KeyNotFoundException
                            ' parent not found in Dictionary.  This can happen if we are 
                            ' adding a NavigationNode to an existing Node that was not
                            ' generated in the XML file. So, go try to find the parent in
                            ' the existing list of QuickLaunch nodes.

                            parentNode = FindQuickLaunchNode(web, parent)

                            If parentNode Is Nothing Then
                                PLLog.Error("Error Processing QuickLaunch Node: >" & nodeName & "<. Parent Node >" & parent & " not found on site.  Check Provisioning XML file.", "OnTrac")
                                Dim exNew As New ApplicationException("Error Processing QuickLaunch Node: >" & nodeName & "< Check Provisioning XML file.", ex)
                                Throw exNew
                            End If

                        End Try

                        parentNode.Children.AddAsLast(lnk)

                    Else
                        lnk = web.Navigation.QuickLaunch.AddAsLast(lnk)
                    End If

                    keys.Add(id, lnk)

                    PLLog.Debug("Added NavBar: " & node.Attributes("Text").Value.ToString, "OnTrac")
                Next

                web.Update()
            Catch ex As Exception
                PLLog.Error("Error Processing QuickLaunch Node: >" & nodeName & "<. Check Provisioning XML file.", "OnTrac") 'rfs11/07
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing QuickLaunch Node: >" & nodeName & "< Check Provisioning XML file.", ex) 'rfs11/07
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

        Private Shared Function FindQuickLaunchNode(ByVal web As SPWeb, ByVal nodeName As String)
            Dim result As SPNavigationNode = Nothing

            For Each node As SPNavigationNode In web.Navigation.QuickLaunch
                If node.Title = nodeName Then
                    Return node
                End If
            Next

            Return result

        End Function

#End Region

#Region "Role Assignments from XML file"
        ' These methods are used to grant principals access to things

        ''' <summary>
        ''' Create RoleAssignments from provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>

        Public Shared Sub ProcessRoleAssignments(ByVal web As SPWeb, ByVal doc As XmlDocument)
            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = ""
            Dim roleAssignmentNodeName As String = ""

            Try
                ' TODO:     Need to make this handle Web, List, other things.

                Dim roleAssignments As XmlNode = doc.DocumentElement.SelectSingleNode("//RoleAssignments")

                For Each roleAssignmentNode As XmlNode In roleAssignments.ChildNodes
                    nodeName = roleAssignmentNode.Name.ToString

                    If nodeName <> "RoleAssignment" Then
                        PLLog.Error("Only <RoleAssignment> elements may be contained in <RoleAssignments></RoleAssignments>", "OnTrac")
                    Else
                        For Each roleAssignmentType As XmlNode In roleAssignmentNode.ChildNodes
                            roleAssignmentNodeName = roleAssignmentType.Name
                            nodeName = nodeName & " " & roleAssignmentNodeName

                            Select Case roleAssignmentType.Name
                                Case "Web"
                                    Dim actions As XmlNodeList = roleAssignmentType.ChildNodes

                                    If Not actions Is Nothing Then
                                        For Each action As XmlNode In actions
                                            nodeName = roleAssignmentNodeName & action.Name

                                            Select Case action.Name.ToUpper()
                                                Case "ADD"
                                                    Dim siteUserName As String = action.Attributes("SiteUser").Value
                                                    Dim userName As String = action.Attributes("User").Value
                                                    Dim siteGroupName As String = action.Attributes("SiteGroup").Value
                                                    Dim groupName As String = action.Attributes("Group").Value
                                                    Dim permissionLevel As String = action.Attributes("PermissionLevel").Value
                                                    Dim principal As SPPrincipal = Nothing

                                                    PLLog.Debug("RoleAssignment: user:>" & userName & "< group:>" & siteGroupName & "< permissionLevel:>" & permissionLevel & "<", "OnTrac")

                                                    If Not web.HasUniqueRoleAssignments Then
                                                        web.AllowUnsafeUpdates = True
                                                        web.BreakRoleInheritance(RoleInheritance.CopyFromParent)
                                                    End If

                                                    If "" <> siteUserName Then
                                                        'Dim user As SPUser = web.SiteUsers.Item(siteUserName)
                                                        'principal = DirectCast(user, SPPrincipal)
                                                        principal = web.SiteUsers.Item(siteUserName)
                                                    End If

                                                    If "" <> userName Then
                                                        'Dim user As SPUser = web.Users.Item(userName)
                                                        'principal = DirectCast(user, SPPrincipal)
                                                        principal = web.Users.Item(userName)
                                                    End If

                                                    If "" <> siteGroupName Then
                                                        'Dim group As SPGroup = web.SiteGroups.Item(siteGroupName)
                                                        'principal = DirectCast(group, SPPrincipal)
                                                        principal = web.SiteGroups.Item(siteGroupName)
                                                    End If

                                                    If "" <> groupName Then
                                                        'Dim group As SPGroup = web.Groups.Item(groupName)
                                                        'principal = DirectCast(group, SPPrincipal)
                                                        principal = web.Groups.Item(groupName)
                                                    End If

                                                    Dim role As SPRoleDefinition = SPHelper.GetRole(web, permissionLevel)

                                                    SPHelper.AddRoleAssignment(web, role, principal)

                                                Case "REMOVE"
                                                    PLLog.Debug("<REMOVE> not implemented", "OnTrac")

                                                Case "REMOVEALL"
                                                    If Not web.HasUniqueRoleAssignments Then
                                                        web.AllowUnsafeUpdates = True
                                                        web.BreakRoleInheritance(RoleInheritance.DoNotCopyFromParent)
                                                    Else
                                                        ' TODO: Note this is not implemented yet.
                                                        SPHelper.RemoveAllRoleAssignments(web)
                                                    End If

                                                Case Else
                                                    PLLog.Error(action.Name & " not supported action.  Only ADD, REMOVE, and REMOVEALL supported.", "OnTrac")

                                            End Select
                                        Next
                                    End If

                                Case "List"
                                    Dim listName As String = roleAssignmentType.Attributes("ListName").Value
                                    ' TODO: Add more error handling here in case can't find list.
                                    Dim list As SPList

                                    Try
                                        list = web.Lists(listName)

                                    Catch ex As Exception
                                        PLLog.Error("Cannot find list >" & listName & "<", "OnTrac")
                                        PLLog.Error(ex, "OnTrac")
                                        GoTo NextRoleAssignmentType
                                    End Try

                                    Dim actions As XmlNodeList = roleAssignmentType.ChildNodes

                                    If Not actions Is Nothing Then
                                        For Each action As XmlNode In actions
                                            nodeName = roleAssignmentNodeName & action.Name

                                            Select Case action.Name.ToUpper()
                                                Case "ADD"
                                                    'Dim listName As String = action.Attributes("ListName").Value
                                                    Dim siteUserName As String = action.Attributes("SiteUser").Value
                                                    Dim userName As String = action.Attributes("User").Value
                                                    Dim siteGroupName As String = action.Attributes("SiteGroup").Value
                                                    Dim groupName As String = action.Attributes("Group").Value
                                                    Dim permissionLevel As String = action.Attributes("PermissionLevel").Value
                                                    Dim principal As SPPrincipal = Nothing

                                                    ' TODO: Add more error handling here in case can't find list.
                                                    'Dim list As SPList = web.Lists(listName)

                                                    PLLog.Debug("RoleAssignment: user:>" & userName & "< group:>" & siteGroupName & "< permissionLevel:>" & permissionLevel & "<", "OnTrac")
                                                    '#If DEBUG Then
                                                    '   PrintGroupsAndUsers(web)
                                                    '#End If

                                                    If Not list.HasUniqueRoleAssignments Then
                                                        web.AllowUnsafeUpdates = True
                                                        list.BreakRoleInheritance(RoleInheritance.CopyFromParent)
                                                    End If

                                                    If "" <> siteUserName Then
                                                        'Dim user As SPUser = web.SiteUsers.Item(siteUserName)
                                                        'principal = DirectCast(user, SPPrincipal)
                                                        principal = web.SiteUsers.Item(siteUserName)
                                                    End If

                                                    If "" <> userName Then
                                                        'Dim user As SPUser = web.Users.Item(userName)
                                                        'principal = DirectCast(user, SPPrincipal)
                                                        principal = web.Users.Item(userName)
                                                    End If

                                                    If "" <> siteGroupName Then
                                                        'Dim group As SPGroup = web.SiteGroups.Item(siteGroupName)
                                                        'principal = DirectCast(group, SPPrincipal)
                                                        principal = web.SiteGroups.Item(siteGroupName)
                                                    End If

                                                    If "" <> groupName Then
                                                        'Dim group As SPGroup = web.Groups.Item(groupName)
                                                        'principal = DirectCast(group, SPPrincipal)
                                                        principal = web.Groups.Item(groupName)
                                                    End If

                                                    Dim role As SPRoleDefinition = SPHelper.GetRole(web, permissionLevel)

                                                    SPHelper.AddRoleAssignment(list, role, principal)

                                                Case "REMOVE"
                                                    PLLog.Debug("<REMOVE> not implemented", "OnTrac")

                                                Case "REMOVEALL"
                                                    SPHelper.RemoveAllRoleAssignments(list)

                                                Case Else
                                                    PLLog.Error(action.Name & " not supported action.  Only ADD, REMOVE, and REMOVEALL supported.", "OnTrac")

                                            End Select
                                        Next
                                    End If
                                Case Else
                                    PLLog.Error(roleAssignmentType.Name & " element not supported.  Only <Web/> and <List/> elements are currently supported.", "OnTrac")
                            End Select
NextRoleAssignmentType:
                        Next
                    End If
                Next

                ' TODO: I don't think we want to break inheritance of RoleDefinitions in this method.  This is certainily out of
                ' place but left in until better understood.

                'If Not web.HasUniqueRoleDefinitions Then
                '    web.AllowUnsafeUpdates = True
                '    web.RoleDefinitions.BreakInheritance(True, True)
                'End If

            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing RoleAssignment Node: >" & nodeName & "< Check Provisioning XML file.", ex)
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

#End Region

#Region "Role Definition (Permission Level) elements from XML file"
        ' These methods are used to interact with the role definitions.
        ' Note: Role Definitions are called Permission Levels in the UI
        '
        ''' <summary>
        ''' Create RoleDefinitions(PermissionLevels) from provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks>Allows PermissionLevels (Roles) to be created, modified, and deleted.</remarks>

        Public Shared Sub ProcessPermissionLevels(ByVal web As SPWeb, ByVal doc As XmlDocument)
            PLLog.Trace("Enter Method", "OnTrac")
            Dim nodeName As String = ""

            Try
                Dim permissionLevel As XmlNodeList = doc.DocumentElement.SelectNodes("//PermissionLevel")

                For Each node As XmlNode In permissionLevel
                    nodeName = node.Name.ToString

                    Dim permissionLevelName As String = node.Attributes("Name").Value
                    Dim description As String = node.Attributes("Description").Value
                    Dim order As String = node.Attributes("Order").Value
                    Dim existingPermissionLevel As String = node.Attributes("CopyFrom").Value

                    PLLog.Debug("PermisisonLevel: Name:>" & permissionLevelName & "<", "OnTrac")

                    If Not web.HasUniqueRoleDefinitions Then
                        web.AllowUnsafeUpdates = True
                        web.RoleDefinitions.BreakInheritance(True, True)
                        web.RoleDefinitions.BreakInheritance(RoleInheritance.CopyFromParent, RoleAssignments.Keep)
                    End If

                    ' Create a new PermissionLevel by copying an existing one or creating an empty new one.
                    ' Otherwise we must be making changes to an existing one.

                    Dim newPermissionLevel As SPRoleDefinition

                    If existingPermissionLevel <> String.Empty Then
                        newPermissionLevel = SPHelper.AddRoleDefinitionToWeb(permissionLevelName, description, Convert.ToInt32(order), existingPermissionLevel, web)
                    ElseIf Not RoleDefinitionExists(permissionLevelName, web) Then
                        newPermissionLevel = SPHelper.AddRoleDefinitionToWeb(permissionLevelName, description, Convert.ToInt32(order), SPBasePermissions.EmptyMask, web)
                    Else
                        newPermissionLevel = web.RoleDefinitions(permissionLevelName)
                    End If

                    ' Check to see if we are making any modifications to the Permission Level

                    Dim permissions As XmlNode = node.SelectSingleNode("Permissions")

                    If Not permissions Is Nothing Then
                        Dim actions As XmlNodeList = permissions.ChildNodes

                        If Not actions Is Nothing Then
                            ' process actions
                            For Each action As XmlNode In actions
                                Select Case action.Name.ToUpper()
                                    Case "ADD"
                                        Dim permission As String = action.Attributes("Permission").Value
                                        PLLog.Debug("ADD permission:>" & permission & "<", "OnTrac")
                                        newPermissionLevel.BasePermissions = (newPermissionLevel.BasePermissions Or GetPermissionByName(permission))
                                        newPermissionLevel.Update()

                                    Case "ADDALL"
                                        PLLog.Debug("ADDALL", "OnTrac")
                                        newPermissionLevel.BasePermissions = SPBasePermissions.FullMask
                                        newPermissionLevel.Update()

                                    Case "REMOVE"
                                        Dim permission As String = action.Attributes("Permission").Value
                                        PLLog.Debug("REMOVE permission:>" & permission & "<", "OnTrac")
                                        newPermissionLevel.BasePermissions = (newPermissionLevel.BasePermissions Xor GetPermissionByName(permission))
                                        newPermissionLevel.Update()

                                    Case "REMOVEALL"
                                        PLLog.Debug("REMOVEALL", "OnTrac")
                                        newPermissionLevel.BasePermissions = SPBasePermissions.EmptyMask
                                        newPermissionLevel.Update()

                                End Select
                            Next
                        End If
                    End If
                Next
            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing PermissionLevel Node: >" & nodeName & "< Check Provisioning XML file.", ex)
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")
        End Sub

        Private Shared Function GetPermissionByName(ByVal permissionName As String) As SPBasePermissions
            Dim result As SPBasePermissions

            Select Case permissionName.ToString.ToUpper
                Case "ADDANDCUSTOMIZEPAGES"
                    result = SPBasePermissions.AddAndCustomizePages

                Case "ADDDELPRIVATEWEBPARTS"
                    result = SPBasePermissions.AddDelPrivateWebParts

                Case "ADDLISTITEMS"
                    result = SPBasePermissions.AddListItems

                Case "APPLYSTYLESHEETS"
                    result = SPBasePermissions.ApplyStyleSheets

                Case "APPLYTHEMEANDBORDER"
                    result = SPBasePermissions.ApplyThemeAndBorder

                Case "APPROVEITEMS"
                    result = SPBasePermissions.ApproveItems

                Case "BROWSEDIRECTORIES"
                    result = SPBasePermissions.BrowseDirectories

                Case "BROWSEUSERINFO"
                    result = SPBasePermissions.BrowseUserInfo

                Case "CANCELCHECKOUT"
                    result = SPBasePermissions.CancelCheckout

                Case "CREATEALERTS"
                    result = SPBasePermissions.CreateAlerts

                Case "CREATEGROUPS"
                    result = SPBasePermissions.CreateGroups

                Case "CREATESSCSITE"
                    result = SPBasePermissions.CreateSSCSite

                Case "DELETELISTITEMS"
                    result = SPBasePermissions.DeleteListItems

                Case "DELETEVERSIONS"
                    result = SPBasePermissions.DeleteVersions

                Case "EDITLISTITEMS"
                    result = SPBasePermissions.EditListItems

                Case "EDITMYUSERINFO"
                    result = SPBasePermissions.EditMyUserInfo

                Case "EMPTYMASK"
                    result = SPBasePermissions.EmptyMask

                Case "ENUMERATEPERMISSIONS"
                    result = SPBasePermissions.EnumeratePermissions

                Case "FULLMASK"
                    result = SPBasePermissions.FullMask

                Case "MANAGEALERTS"
                    result = SPBasePermissions.ManageAlerts

                Case "MANAGEPERMISSIONS"
                    result = SPBasePermissions.ManagePermissions

                Case "MANAGEPERSONALVIEWS"
                    result = SPBasePermissions.ManagePersonalViews

                Case "MANAGESUBWEBS"
                    result = SPBasePermissions.ManageSubwebs

                Case "MANAGEWEB"
                    result = SPBasePermissions.ManageWeb

                Case "OPEN"
                    result = SPBasePermissions.Open

                Case "OPENITEMS"
                    result = SPBasePermissions.OpenItems

                Case "UPDATEPERSONALWEBPARTS"
                    result = SPBasePermissions.UpdatePersonalWebParts

                Case "USECLIENTINTEGRATION"
                    result = SPBasePermissions.UseClientIntegration

                Case "USEREMOTEAPIS"
                    result = SPBasePermissions.UseRemoteAPIs

                Case "VIEWFORMPAGES"
                    result = SPBasePermissions.ViewFormPages

                Case "VIEWUSAGEDATA"
                    result = SPBasePermissions.ViewUsageData

                Case "VIEWVERSIONS"
                    result = SPBasePermissions.ViewVersions

                Case Else
                    Throw New ApplicationException("Invalid permission:>" & permissionName & "< check Provisioning XML file")
            End Select

            Return result
        End Function

#End Region

#Region "Top Navigation elements from XML file"
        ' These methods are used to interact with the Top Navigation bar.

        ''' <summary>
        ''' Create TopNavigation from provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>

        Public Shared Sub ProcessTopNavigation(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = ""

            Try
                Dim views As XmlNode = doc.DocumentElement.SelectSingleNode("//Top")
                Dim keys As New Dictionary(Of String, SPNavigationNode)

                For Each node As XmlNode In views.ChildNodes
                    nodeName = node.Name.ToString
                    Dim parent As String = node.Attributes("Parent").Value
                    Dim id As String = node.Attributes("Id").Value

                    Dim parentNode As SPNavigationNode
                    Dim lnk As SPNavigationNode

                    lnk = New SPNavigationNode(node.Attributes("Text").Value, ReplaceTokens(node.Attributes("Url").Value, web), Boolean.Parse(node.Attributes("External").Value))
                    lnk.Properties.Add("target", "_blank")

                    If parent <> String.Empty Then
                        parentNode = keys(parent)
                        parentNode.Children.AddAsLast(lnk)
                    Else
                        lnk = web.Navigation.TopNavigationBar.AddAsLast(lnk)
                    End If

                    keys.Add(id, lnk)

                    PLLog.Debug("Added TopNavigation: " & node.Attributes("Text").Value.ToString, "OnTrac")
                Next

                web.Update()
            Catch ex As Exception
                PLLog.Error("Error Processing Top Node: >" & nodeName & "<. Check Provisioning XML file.", "OnTrac") 'rfs11/07
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing Top Node: >" & nodeName & "< Check Provisioning XML file.", ex) 'rfs11/07
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

#End Region

#Region "Users and Groups elements from XML file"
        ' These methods are used to interact with users and groups

        ''' <summary>
        ''' Add Users from provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>

        Public Shared Sub ProcessUsers(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = ""

            Try
                Dim groups As XmlNodeList = doc.DocumentElement.SelectNodes("//User")

                For Each node As XmlNode In groups
                    nodeName = node.Name.ToString

                    Dim groupName As String = node.Attributes("Name").Value
                    Dim desc As String = node.Attributes("Description").Value

                    PLLog.Debug("Groups: name:>" & groupName & "<", "OnTrac")

                    Dim group As SPGroup
#If DEBUG Then
                    System.Diagnostics.Debug.WriteLine(web.Title & " " & web.SiteGroups.Count)

                    For Each grp As SPGroup In web.SiteGroups
                        System.Diagnostics.Debug.WriteLine(grp.ID & ":" & grp.Name & ":" & grp.Description)
                    Next
#End If
                    'Try
                    '    ' Check to see if group exists, create if necessary.
                    '    ' This allows us to add users to the default SharePoint groups
                    '    ' that are automatically created.
                    '    ' Actually they don't seem to be created yet.  Hum.
                    '    group = web.SiteGroups.Item(name)
                    'Catch ex As ApplicationException
                    '    web.SiteGroups.Add(name, web.Site.Owner, web.Site.Owner, desc)
                    '    group = web.SiteGroups.Item(name)
                    'End Try

                    group = GetSiteGroup(web, groupName)

                    If group Is Nothing Then
                        web.SiteGroups.Add(groupName, web.Site.Owner, web.Site.Owner, desc)
                        web.Update()
                        group = GetSiteGroup(web, groupName)
                    End If

#If DEBUG Then
                    PrintKeysAndValues(web.Properties)
#End If
                    ' These properties vti_associate* do not exist yet.
                    ' The only properties that exist at this point are
                    '   vti_extenderversion 12.0.0.4518
                    '   vti_defaultlanguage en-us
                    '
                    ' If this code is not called, an error is returned when
                    ' after the Provision process completes and SharePoint does
                    ' something to create the default groups.
                    '
                    '   The specified name is already in use.
                    '   Please try again with a new name. 
                    '
                    ' Calling the code below that updates the vti_associated*group
                    ' properties seems to make SharePoint happy.
                    '
                    ' TODO: Seems like if we create the group we also have to associate it with an appropriate 
                    ' role definition (permisison level) or it does not do anything to moderate access.
                    ' 
                    ' This is currently not done!

                    Try
                        Select Case groupName
                            Case web.Title & " Owners"
                                web.Properties("vti_associateownergroup") = group.ID.ToString
                                web.Properties.Update()

                            Case web.Title & " Members"
                                web.Properties("vti_associatemembergroup") = group.ID.ToString
                                web.Properties.Update()

                            Case web.Title & " Visitors"
                                web.Properties("vti_associatevisitorgroup") = group.ID.ToString
                                web.Properties.Update()

                        End Select
                    Catch ex As Exception

                    End Try

                    Dim users As XmlNode = node.SelectSingleNode("Users")

                    If Not users Is Nothing Then
                        Dim actions As XmlNodeList = users.ChildNodes

                        If Not actions Is Nothing Then
                            'Dim group As SPGroup = web.SiteGroups(name)
                            ' process actions
                            For Each action As XmlNode In actions
                                Select Case action.Name.ToUpper()
                                    Case "REMOVEALL"
                                        PLLog.Debug("REMOVEALL", "OnTrac")
                                        RemoveAllUsers(group)

                                    Case "ADD"
                                        Dim login As String = action.Attributes("Login").Value
                                        Dim userName As String = action.Attributes("Name").Value
                                        Dim email As String = action.Attributes("Email").Value
                                        Dim notes As String = action.Attributes("Notes").Value

                                        PLLog.Debug("ADD: login:>" & login & "<", "OnTrac")

                                        group.Users.Add(login, email, userName, notes)

                                    Case "REMOVE"
                                        PLLog.Debug("REMOVE not implemented", "OnTrac")

                                End Select
                            Next

                            group.Update()
                        End If
                    End If
                Next
            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing Users Node: >" & nodeName & "< Check Provisioning XML file.", ex)
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

        ''' <summary>
        ''' Add Groups from provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>

        Public Shared Sub ProcessGroups(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = ""

            Try
                Dim groups As XmlNodeList = doc.DocumentElement.SelectNodes("//Group")

                For Each node As XmlNode In groups
                    nodeName = node.Name.ToString

                    Dim groupName As String = node.Attributes("Name").Value
                    Dim desc As String = node.Attributes("Description").Value

                    PLLog.Debug("Groups: name:>" & groupName & "<", "OnTrac")

                    Dim group As SPGroup
#If DEBUG Then
                    System.Diagnostics.Debug.WriteLine(web.Title & " " & web.SiteGroups.Count)

                    For Each grp As SPGroup In web.SiteGroups
                        System.Diagnostics.Debug.WriteLine(grp.ID & ":" & grp.Name & ":" & grp.Description)
                    Next
#End If
                    'Try
                    '    ' Check to see if group exists, create if necessary.
                    '    ' This allows us to add users to the default SharePoint groups
                    '    ' that are automatically created.
                    '    ' Actually they don't seem to be created yet.  Hum.
                    '    group = web.SiteGroups.Item(name)
                    'Catch ex As ApplicationException
                    '    web.SiteGroups.Add(name, web.Site.Owner, web.Site.Owner, desc)
                    '    group = web.SiteGroups.Item(name)
                    'End Try

                    group = GetSiteGroup(web, groupName)

                    If group Is Nothing Then
                        web.SiteGroups.Add(groupName, web.Site.Owner, web.Site.Owner, desc)
                        group = GetSiteGroup(web, groupName)
                    End If

#If DEBUG Then
                    PrintKeysAndValues(web.Properties)
#End If
                    ' These properties vti_associate* do not exist yet.
                    ' The only properties that exist at this point are
                    '   vti_extenderversion 12.0.0.4518
                    '   vti_defaultlanguage en-us
                    '
                    ' If this code is not called, an error is returned when
                    ' after the Provision process completes and SharePoint does
                    ' something to create the default groups.
                    '
                    '   The specified name is already in use.
                    '   Please try again with a new name. 
                    '
                    ' Calling the code below that updates the vti_associated*group
                    ' properties seems to make SharePoint happy.
                    '
                    ' TODO: Seems like if we create the group we also have to associate it with an appropriate 
                    ' role definition (permisison level) or it does not do anything to moderate access.
                    ' 
                    ' This is currently not done!

                    Try
                        Select Case groupName
                            Case web.Title & " Owners"
                                web.Properties("vti_associateownergroup") = group.ID.ToString
                                web.Properties.Update()

                            Case web.Title & " Members"
                                web.Properties("vti_associatemembergroup") = group.ID.ToString
                                web.Properties.Update()

                            Case web.Title & " Visitors"
                                web.Properties("vti_associatevisitorgroup") = group.ID.ToString
                                web.Properties.Update()

                        End Select
                    Catch ex As Exception

                    End Try

                    Dim users As XmlNode = node.SelectSingleNode("Users")

                    If Not users Is Nothing Then
                        Dim actions As XmlNodeList = users.ChildNodes

                        If Not actions Is Nothing Then
                            'Dim group As SPGroup = web.SiteGroups(name)
                            ' process actions
                            For Each action As XmlNode In actions
                                Select Case action.Name.ToUpper()
                                    Case "REMOVEALL"
                                        PLLog.Debug("REMOVEALL", "OnTrac")
                                        RemoveAllUsers(group)

                                    Case "ADD"
                                        Dim login As String = action.Attributes("Login").Value
                                        Dim userName As String = action.Attributes("Name").Value
                                        Dim email As String = action.Attributes("Email").Value
                                        Dim notes As String = action.Attributes("Notes").Value

                                        PLLog.Debug("ADD: login:>" & login & "<", "OnTrac")

                                        group.Users.Add(login, email, userName, notes)

                                    Case "REMOVE"
                                        PLLog.Debug("REMOVE not implemented", "OnTrac")

                                    Case Else
                                        PLLog.Error(action.Name & " not supported action.  Only ADD, REMOVE, and REMOVEALL supported.", "OnTrac")

                                End Select
                            Next

                            group.Update()
                        End If
                    End If
                Next
            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing Groups Node: >" & nodeName & "< Check Provisioning XML file.", ex) 'rfs11/07
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

#End Region

#Region "Views elements from XML file"
        ' These methods are used to create views on lists and libraries

        ''' <summary>
        ''' Create Views from Provisioning XML file
        ''' </summary>
        ''' <param name="web"></param>
        ''' <param name="doc"></param>
        ''' <remarks></remarks>

        Public Shared Sub ProcessViews(ByVal web As SPWeb, ByVal doc As XmlDocument)

            PLLog.Trace("Enter Method", "OnTrac")

            Dim nodeName As String = ""

            Try
                Dim views As XmlNode = doc.DocumentElement.SelectSingleNode("//Views")

                For Each node As XmlNode In views.ChildNodes
                    nodeName = node.Name.ToString

                    If node.Name = "AddField" Then
                        Dim listName As String = node.Attributes("ListName").Value
                        Dim viewName As String = node.Attributes("ViewName").Value
                        Dim fieldName As String = node.Attributes("FieldName").Value

                        PLLog.Debug("AddField: listName:>" & listName & "< viewName:>" & viewName & "< fieldName:>" & fieldName & "<", "OnTrac")

                        Dim List As SPList = web.Lists.Item(listName)
                        Dim View As SPView = List.Views.Item(viewName)

                        View.ViewFields.Add(fieldName)
                        View.Update()
                    End If
                Next
            Catch ex As Exception
                PLLog.Error(ex, "OnTrac")
                PLLog.Trace("Exit MethodEX", "OnTrac")

                Dim exNew As New ApplicationException("Error Processing Views Node: >" & nodeName & "< Check Provisioning XML file.", ex) 'rfs11/07
                Throw exNew
            End Try

            PLLog.Trace("Exit Method", "OnTrac")

        End Sub

#End Region

    End Class

#End Region

#Region "Diagnostic Print Routines"
    ' Routines to display various things.  Used while in IDE.

    Public Shared Sub PrintKeysAndValues(ByVal myCol As StringDictionary)
        System.Diagnostics.Debug.WriteLine("   KEY                       VALUE")
        Dim de As DictionaryEntry
        For Each de In myCol
            System.Diagnostics.Debug.WriteLine(String.Format("   {0,-25} {1}", de.Key, de.Value))
        Next de
        System.Diagnostics.Debug.WriteLine("")
    End Sub

    Public Shared Sub PrintRoles(ByVal web As SPWeb)
        System.Diagnostics.Debug.WriteLine("   Id      Name     Type")

        For Each role As SPRoleDefinition In web.RoleDefinitions
            System.Diagnostics.Debug.WriteLine(String.Format("   {0,-25} {1}  {2}", role.Id, role.Name, role.Type.ToString))
        Next

        System.Diagnostics.Debug.WriteLine("")
    End Sub

    Public Shared Sub PrintGroupsAndUsers(ByVal web As SPWeb)
        System.Diagnostics.Debug.WriteLine("SiteGroups   Name    Id")

        For Each principal As SPPrincipal In web.SiteGroups
            System.Diagnostics.Debug.WriteLine(String.Format("   >{0}< {1}", principal.Name, principal.ID))
        Next

        System.Diagnostics.Debug.WriteLine("Groups       Name    Id")

        For Each principal As SPPrincipal In web.Groups
            System.Diagnostics.Debug.WriteLine(String.Format("   >{0}< {1}", principal.Name, principal.ID))
        Next

        System.Diagnostics.Debug.WriteLine("SiteUsers   Name    Id")

        'For Each principal As SPPrincipal In web.SiteUsers
        '    System.Diagnostics.Debug.WriteLine(String.Format("   >{0}< {1}", principal.Name, principal.ID))
        'Next

        For Each user As SPUser In web.SiteUsers
            System.Diagnostics.Debug.WriteLine(String.Format("   >{0}< {1}", user.Name, user.LoginName, user.ID))
        Next

        System.Diagnostics.Debug.WriteLine("Users   Name    Id")

        For Each principal As SPPrincipal In web.Users
            System.Diagnostics.Debug.WriteLine(String.Format("   >{0}< {1}", principal.Name, principal.ID))
        Next

        System.Diagnostics.Debug.WriteLine("")
    End Sub
#End Region

End Class
