USE [MCRRequests]
GO
/****** Object:  StoredProcedure [dbo].[plsp_PurgeRequest]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_PurgeRequest]

/*******************************************************************************
* Description : Deletes a request and all reports associated with
*   that request, based on the RequestID from any of the request
*   tables.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      06/02/03    John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      10/24/2003  John S      Updated to delete history data
*      11/05/2003  John S      change 'DELETE HistoryReports WHERE HistoryID = (select...'
*                              to 'DELETE HistoryReports WHERE HistoryID IN (select...'
*      06/01/2004  MikeT       Prefix table names with dbo.
*      06/17/2004  John S      Changed Status parameter to varchar
*
*******************************************************************************/

@iRequestID int = null,
@cListbill varchar(10) = null,
@cStatus varchar(10)

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(1000),
                    @cFilter varchar(100)

  SET @cFilter = '   WHERE Status IN (' + @cStatus + ')'

  IF (@iRequestID IS NOT NULL)
    SET @cFilter = @cFilter + '     AND [ID] = ' + CONVERT(varchar, @iRequestID) + CHAR(13)
  ELSE IF (@cListbill IS NOT NULL)
    SET @cFilter = @cFilter + '     AND Listbill = ''' + @cListbill + '''' + CHAR(13)

  --Delete the history of requested reports
  SET @cSQL = 'DELETE' + CHAR(13)
    + 'FROM dbo.HistoryReports' + CHAR(13)
    + 'WHERE HISTORYID IN( ' + CHAR(13)
    + '  (SELECT [ID]' + CHAR(13)
    + '    FROM RequestHistory' + CHAR(13)
    + '    WHERE RequestID = ' + CHAR(13)
    + '  (SELECT [ID]' + CHAR(13)
    + '   FROM Requests' + CHAR(13)
    + @cFilter + ')))'

  EXEC (@cSQL)

  --Delete the history of changes to the request
  SET @cSQL = 'DELETE' + CHAR(13)
    + 'FROM dbo.RequestHistory' + CHAR(13)
    + 'WHERE RequestID =' + CHAR(13)
    + '  (SELECT [ID]' + CHAR(13)
    + '   FROM Requests' + CHAR(13)
    + @cFilter + ')'

  EXEC (@cSQL)

  --Delete the reports for the request
  SET @cSQL = 'DELETE' + CHAR(13)
    + 'FROM dbo.RequestedReports' +  CHAR(13)
    + 'WHERE RequestID =' + CHAR(13)
    + '  (SELECT [ID]' + CHAR(13)
    + '   FROM Requests' + CHAR(13)
    + @cFilter + ')'

  EXEC (@cSQL)

  --Delete the request itself
  SET @cSQL = 'DELETE' + CHAR(13)
    + 'FROM dbo.Requests' + CHAR(13)
    + @cFilter

  EXEC (@cSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetDetailedRequests]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[plsp_GetDetailedRequests]

/*******************************************************************************
* Description : Gets detailed information about all active unprocessed requests.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      10/11/2004  John S      Intial Development
*      12/08/2004  John S      Changed the ReportArchive join to a LEFT join
*
*******************************************************************************/

@Where varchar(2500) = null

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @Select varchar(8000)

  IF (@Where IS NULL)
  BEGIN
    SET @Where = 'WHERE datediff(d, Submitted, getdate()) <= 120 AND ((R.Status = 1)' + CHAR(13)
    + '  OR (R.Status = 5 And R.Processed IS NULL))' + CHAR(13)
  END
 
  SET @Select = 'SELECT DISTINCT R.[ID],' + CHAR(13)
  + '  R.ListBill,' + CHAR(13)
  + '  R.Office, ' + CHAR(13)
  + '  R.Requestor, ' + CHAR(13)
  + '  ProductFamily = (SELECT [Description] FROM Upkeep WHERE Category = ''Product Family'' AND ItemValue = AR.Product), ' + CHAR(13)
  + '  Frequency = (SELECT [Description] FROM Upkeep WHERE Category = ''Frequency'' AND ItemValue = R.Frequency),' + CHAR(13)
  + '  FrequencyID = (SELECT ItemValue FROM Upkeep WHERE Category = ''Frequency'' AND ItemValue = R.Frequency),' + CHAR(13)
  + '  Timeframe = (SELECT [Description] FROM Upkeep WHERE Category = ''Timeframe'' AND ItemValue = R.Timeframe),' + CHAR(13)
  + '  TimeframeID = (SELECT ItemValue FROM Upkeep WHERE Category = ''Timeframe'' AND ItemValue = R.Timeframe),' + CHAR(13)
  + '  R.PeriodStart,' + CHAR(13)
  + '  R.PeriodEnd,' + CHAR(13)
  + '  R.AssumePremiumsPaid,' + CHAR(13)
  + '  R.Notes,' + CHAR(13)
  + '  R.Status, ' + CHAR(13)
  + '  RR.ReportID,' + CHAR(13)
  + '  ReportName = AR.Name,' + CHAR(13)
  + '  AR.Acronym,' + CHAR(13)
  + '  AR.DocTypeCode' + CHAR(13)
  + 'FROM Requests R' + CHAR(13)
  + '  JOIN RequestedReports RR' + CHAR(13)
  + '    ON R.[ID] = RR.RequestID' + CHAR(13)
  + '  JOIN AvailableReports AR' + CHAR(13)
  + '    ON RR.ReportID = AR.[ID]' + CHAR(13)
  + '  LEFT JOIN ReportArchive RA' + CHAR(13)
  + '    ON RA.RequestID = R.[ID]' + CHAR(13)
  + @Where

  EXEC(@Select)

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_ProcessingError]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_ProcessingError]

/***********************************************************************************************************
** Name            : plsp_ProcessingError.SQL 
** Description     : This is a Stored Procedure
** Author          : Mike Tarrant
** 
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      09/09/03    MikeT       Intial Dev
**      10/09/2003  MikeT       grant execute 
**
**
***********************************************************************************************************/ 






      @cListBill      varchar(10) = null
    , @cOffice        varchar(10) = null
    , @iProductFamily int         = null
    , @dBegin         datetime    = null
    , @dEnd           datetime    = null
    , @iTimeframe     int         = null
    , @iFrequency     int         = null
    , @iReport        int         = null


    
AS
BEGIN
    SET NOCOUNT ON


    DECLARE @sBegin char(10), @sEnd char(10)

    IF( @dBegin IS NOT null AND @dEnd IS NOT null)
    BEGIN

        SELECT   @sBegin    =  CONVERT(varchar, @dBegin, 101)
               , @sEnd      =  CONVERT(varchar, @dEnd,   101) 

    END


    DECLARE       @SQLReport            varchar(8000)
                , @WhereReport          varchar(4000)
                , @SQLRequest           varchar(8000)
                , @WhereRequest         varchar(4000)
                , @Order                char(92)
                , @Server               varchar(16)





    /*
    Type
    Description     ItemValue  
    --------------- -----------
    Notification    1
    Warning         2
    Error           3
    Success         4

    */

    IF(@@SERVERNAME = 'JSTEGAL601\JSTEGAL601')
    BEGIN
        SET @Server = '[TLABSQL08\MCR].'
    END
    ELSE
    BEGIN
        SET @Server = ''
    END



    SELECT    @SQLReport =
                'SELECT    Source = ''MCReport''  '
                        +' , p.instanceid '
                        +' , i.RequestID '
                        +' , r.Office '
                        +' , ProductFamily = pf.Description '
                        +' , p.Listbill '
                        +' , LC_Name '
                        +' , Acronym '
                        +' , i.PeriodStart '
                        +' , i.PeriodEnd '
                        +' , Occurrence    = p.ProcessDate '
                        +' , Type          = CASE p.Success WHEN 1 THEN ''Success'' ELSE ''Error'' END '
                        +' , p.Description ' + char(13)
                +'FROM ' + @Server + 'MCReport.dbo.ProcessLog p '
                    +'  JOIN dbo.requestinstance i      ON p.InstanceID = i.InstanceID ' + char(13) 
                    +'  JOIN dbo.Requests r             ON i.RequestID  = r.ID '         + char(13) 
                    +'  JOIN dbo.RequestedReports rr    ON i.RequestID  = rr.RequestID ' + char(13) 
                    +'  JOIN dbo.AvailableReports ar     ON rr.ReportID = ar.ID '        + char(13) 
                    +'  JOIN dbo.upkeep pf               ON ar.product  = pf.itemvalue and pf.category = ''Product Family''  ' + char(13) 
                    +'  LEFT JOIN ' + @Server + 'superset.dbo.LISTBILL_CLIENT n ON p.Listbill = n.LC_Listbill_Number '       + char(13) 
            , @SQLRequest = 
                'SELECT    Source = ''MCRequests''  '
                        +' , p.instanceid '
                        +' , i.RequestID '
                        +' , r.Office '
                        +' , ProductFamily = pf.Description '
                        +' , r.Listbill '
                        +' , lc.LC_Name '
                        +' , Acronym '
                        +' , i.PeriodStart '   
                        +' , i.PeriodEnd '     
                        +' , p.Occurrence '
                        +' , Type          = et.Description '
                        +' , p.[Description] ' + char(13)
                +'FROM dbo.ProcessLog p '
                    +'  JOIN dbo.RequestInstance i      ON p.InstanceID = i.InstanceID '  + char(13) 
                    +'  JOIN dbo.Requests r             ON p.RequestID  = r.[ID] '        + char(13) 
                    +'  JOIN dbo.AvailableReports ar    ON p.ReportID   = ar.[ID] '       + char(13) 
                    +'  JOIN (SELECT Description, ItemValue FROM dbo.Upkeep WHERE Category = ''Product Family'' )  pf ON  pf.ItemValue = AR.Product ' + char(13)
                    +'  JOIN (SELECT Description, ItemValue FROM dbo.Upkeep WHERE Category = ''Event Type''  )  et ON et.ItemValue = p.Type ' + char(13)
                    +'  LEFT JOIN ' + @Server + 'SuperSet.DBO.LISTBILL_CLIENT lc ON R.Listbill = lc.LC_Listbill_Number ' + char(13) 
            , @Order = 'ORDER BY 11 /* p.ProcessDate*/ desc, 6 /* Listbill */ asc, p.instanceID asc, Acronym asc '       + char(13) 
            , @WhereReport  = 'WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30 ' + char(13)
            , @WhereRequest = 'WHERE DATEDIFF(day, p.Occurrence , GETDATE()) <= 30 ' + char(13)









     IF( @cListBill      is not null )
     BEGIN
        SELECT  @WhereReport  = @WhereReport  + 'AND p.Listbill = ' + char(39) + @cListBill + char(39) + ' '
              , @WhereRequest = @WhereRequest + 'AND r.Listbill = ' + char(39) + @cListBill + char(39) + ' '
     END

     IF( @cOffice        is not null )
     BEGIN
        SELECT  @WhereReport  = @WhereReport  + 'AND r.Office = ' + char(39) + @cOffice + char(39) + ' '
              , @WhereRequest = @WhereRequest + 'AND r.Office = ' + char(39) + @cOffice + char(39) + ' '
     END

     IF( @iProductFamily is not null )
     BEGIN
        SELECT  @WhereReport  = @WhereReport  + 'AND pf.ItemValue = ' +  CONVERT(VARCHAR, @iProductFamily) + ' '
              , @WhereRequest = @WhereRequest + 'AND pf.ItemValue = ' +  CONVERT(VARCHAR, @iProductFamily) + ' '
     END

     IF( @dBegin         is not null AND @dEnd is not null )
     BEGIN
        SELECT  @WhereReport  = @WhereReport  + 'AND CONVERT(varchar, p.ProcessDate, 101) BETWEEN ' + char(39) + @sBegin + char(39) + ' AND ' + char(39) + @sEnd + char(39) + ' '
              , @WhereRequest = @WhereRequest + 'AND CONVERT(varchar, p.Occurrence , 101) BETWEEN ' + char(39) + @sBegin + char(39) + ' AND ' + char(39) + @sEnd + char(39) + ' '
     END


     IF( @iTimeframe     is not null )
     BEGIN
        SELECT  @WhereReport  = @WhereReport  + 'AND r.Timeframe = ' + CONVERT(VARCHAR, @iTimeframe)  + ' '
              , @WhereRequest = @WhereRequest + 'AND r.Timeframe = ' + CONVERT(VARCHAR, @iTimeframe)  + ' '
     END

     IF( @iFrequency     is not null )
     BEGIN
        SELECT  @WhereReport  = @WhereReport  + 'AND r.Frequency = ' + CONVERT(VARCHAR, @iFrequency) + ' '
              , @WhereRequest = @WhereRequest + 'AND r.Frequency = ' + CONVERT(VARCHAR, @iFrequency) + ' '
     END

     IF( @iReport        is not null )
     BEGIN
        SELECT  @WhereReport  = @WhereReport  + 'AND ar.ID = ' + CONVERT(VARCHAR, @iReport) + ''
              , @WhereRequest = @WhereRequest + 'AND ar.ID = ' + CONVERT(VARCHAR, @iReport) + ''
     END






--    PRINT @SQLReport + @WhereReport + 'UNION ' + char(13) + @SQLRequest + @WhereRequest + @Order       

    EXEC (@SQLReport + @WhereReport + 'UNION ' + @SQLRequest + @WhereRequest + @Order)







END --CREATE PROCEDURE [dbo].[PLSP_ProcessingError]
GO
/****** Object:  StoredProcedure [dbo].[plsp_Parse_String]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_Parse_String]

/***********************************************************************************************************
* Name            : plsp_Parse_String.SQL 
* Description     : Parses a comma seperated string and inserts into the table #list
*   #list must allready exist with one column of varchar.
* Author          : Mike Tarrant
* 
*      Date        By          Notes
*      ----------  ----------  ---------------------------------------------------------------------------
*      05/07/01    MikeT       Created
*      10/09/2003  MikeT       grant execute 
*
***********************************************************************************************************/ 
    
@string VARCHAR(8000),
@table  VARCHAR(100) = '#list'

AS
BEGIN 

  DECLARE @tempString varchar(8000),
                    @sql varchar(8000)

  WHILE LEN(ISNULL(@string,'')) > 0
  BEGIN
    IF (CHARINDEX(',',@string) > 0)
    BEGIN
      SELECT @tempString = LEFT(@string, CHARINDEX(',', @string) - 1) 	
      SELECT @string = SUBSTRING(@string, CHARINDEX(',',@string)+1, LEN(@string))
    END
    ELSE
    BEGIN
      SELECT @tempString = @string
      SELECT @string = ''
    END

    SET @sql = 'insert ' + @table + ' values(RTRIM(LTRIM( ' + CHAR(39)+ @tempstring + CHAR(39) +' ))) '

    EXEC (@sql)
  END

END         --CREATE PROCEDURE [dbo].[plsp_Parse_String]
GO
/****** Object:  StoredProcedure [dbo].[plsp_Lookup]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_Lookup]

/*******************************************************************************
* Description : Retrieves all/active values for a given category.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      05/30/03    John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@cCategory varchar(50),
@iValue int = null,
@cDescription varchar(50) = null,
@bActive bit = null

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(1000),
                    @cFilter varchar(100)

  SET @cFilter = 'WHERE Category = ''' + @cCategory + '''' + CHAR(13)

  IF (@iValue IS NOT NULL)
    SET @cFilter = @cFilter + '  AND ItemValue = ' + CONVERT(varchar, @iValue) + CHAR(13)

  IF (@bActive IS NOT NULL)
    SET @cFilter = @cFilter + '  AND Active = ' + CONVERT(varchar, @bActive) + CHAR(13)

  IF (@cDescription IS NOT NULL)
    SET @cFilter = @cFilter + '  AND Description = ''' + @cDescription + '''' + CHAR(13)

  SET @cSQL = 'SELECT Description,' + CHAR(13)
    + '  ItemValue' + CHAR(13)
    + 'FROM dbo.Upkeep' + CHAR(13)
    + @cFilter
    + 'ORDER BY Description'

  EXEC (@cSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetRequestsNoReports]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetRequestsNoReports]

/*******************************************************************************
* Description : Gets all the requests from any request table, using a
*   given listbill or RequestID but does not include reports.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      04/19/2003  John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@cListBill  varchar(10) = null,
@iRequestID int = null,
@iStatus int

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(1000),
                    @cFilter varchar(100)

  SET @cFilter = 'WHERE R.Status = ' + CONVERT(varchar, @iStatus) + CHAR(13)

  IF (@cListBill IS NOT NULL)
    SET @cFilter = @cFilter + '  AND R.ListBill = ''' + @cListBill + '''' + CHAR(13)
  ELSE IF (@iRequestID IS NOT NULL)
    SET @cFilter = @cFilter + '  AND R.[ID] = ' + CONVERT(varchar, @iRequestID) + CHAR(13)

  SET @cSQL = 'SELECT R.[ID],' + CHAR(13)
    + '  R.ListBill,' + CHAR(13)
    + '  Frequency = (SELECT [Description] FROM dbo.Upkeep WHERE Category = ''Frequency'' AND ItemValue = R.Frequency),' + CHAR(13)
    + '  FrequencyID = (SELECT ItemValue FROM dbo.Upkeep WHERE Category = ''Frequency'' AND ItemValue = R.Frequency),' + CHAR(13)
    + '  Timeframe = (SELECT [Description] FROM dbo.Upkeep WHERE Category = ''Timeframe'' AND ItemValue = R.Timeframe),' + CHAR(13)
    + '  TimeframeID = (SELECT ItemValue FROM dbo.Upkeep WHERE Category = ''Timeframe'' AND ItemValue = R.Timeframe),' + CHAR(13)
    + '  R.PeriodStart,' + CHAR(13)
    + '  R.PeriodEnd,' + CHAR(13)
    + '  R.AssumePremiumsPaid,' + CHAR(13)
    + '  R.Notes' + CHAR(13)
    + '  FROM dbo.Requests R' + CHAR(13)
    + @cFilter

  EXEC (@cSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetRequests]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetRequests]

/*******************************************************************************
* Description : Gets all the requests from any request table, using a
*   given listbill or RequestID.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      04/19/2003  John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      11/14/2003  MikeT       add Requestor to output
*      03/08/2004  John S			 Changed the iStatus filter/parameter
*      03/16/2004  John S      Added Status to the output
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@cListBill  varchar(10) = null,
@iRequestID int = null,
@iStatus varchar(50)

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(1000),
          @cFilter varchar(100)

  SET @cFilter = 'WHERE R.Status IN (' + CONVERT(varchar, @iStatus) + ')' + CHAR(13)

  IF (@cListBill IS NOT NULL)
    SET @cFilter = @cFilter + '  AND R.ListBill = ''' + @cListBill + '''' + CHAR(13)
  ELSE IF (@iRequestID IS NOT NULL)
    SET @cFilter = @cFilter + '  AND R.[ID] = ' + CONVERT(varchar, @iRequestID) + CHAR(13)

  SET @cSQL = 'SELECT R.[ID],' + CHAR(13)
    + '  R.ListBill,' + CHAR(13)
    + '  RR.ReportID,' + CHAR(13)
    + '  AR.Name,' + CHAR(13)
    + '  AR.Acronym,' + CHAR(13)
    + '  Frequency = (SELECT [Description] FROM Upkeep WHERE Category = ''Frequency'' AND ItemValue = R.Frequency),' + CHAR(13)
    + '  FrequencyID = (SELECT ItemValue FROM Upkeep WHERE Category = ''Frequency'' AND ItemValue = R.Frequency),' + CHAR(13)
    + '  Timeframe = (SELECT [Description] FROM Upkeep WHERE Category = ''Timeframe'' AND ItemValue = R.Timeframe),' + CHAR(13)
    + '  TimeframeID = (SELECT ItemValue FROM Upkeep WHERE Category = ''Timeframe'' AND ItemValue = R.Timeframe),' + CHAR(13)
    + '  R.PeriodStart,' + CHAR(13)
    + '  R.PeriodEnd,' + CHAR(13)
    + '  R.AssumePremiumsPaid,' + CHAR(13)
    + '  R.Notes,' + CHAR(13)
    + '  R.Requestor, ' + CHAR(13)
    + '  R.Status ' + CHAR(13)
    + 'FROM dbo.Requests R' + CHAR(13)
    + '    JOIN dbo.RequestedReports RR' + CHAR(13)
    + '      ON R.[ID] = RR.RequestID' + CHAR(13)
    + '    JOIN dbo.AvailableReports AR' + CHAR(13)
    + '      ON RR.ReportID = AR.[ID]' + CHAR(13)
    + @cFilter


  EXEC (@cSQL)

END         --CREATE PROCEDURE [dbo].[plsp_GetRequests]
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetRequestableReports]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[plsp_GetRequestableReports]

/*******************************************************************************
* Description: Retrieves a list of reports to be displayed for requesting.  This
*              gathers all reports that should always be displayed, as well as
*              any conditional reports that are available.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  -------------------------------------------------
*      04/19/03    John S      Intial Development
*      09/30/03    MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@iProduct varchar(10),
@cListbill varchar(10) = null,
@iTimeframe int = null

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(4000),
          @cFilter varchar(1000)

  SET @cFilter = 'WHERE A.Conditional = 0' + CHAR(13)
    + '  OR (A.Conditional = 1' + CHAR(13)

  IF (@cListbill IS NOT NULL AND @iTimeframe IS NULL)
    SET @cFilter = @cFilter + CHAR(13) + '    AND (C.Listbill = ''' + @cListbill + ''' AND C.Timeframe IS NULL))' + CHAR(13)
  ELSE IF (@cListbill IS NULL AND @iTimeframe IS NOT NULL)
    SET @cFilter = @cFilter + CHAR(13) + '    AND (C.Timeframe = ' + CONVERT(varchar, @iTimeframe) + ' AND Listbill IS NULL))' + CHAR(13)
  ELSE IF (@cListbill IS NOT NULL AND @iTimeframe IS NOT NULL)
  BEGIN
    SET @cFilter = @cFilter + CHAR(13) + '    AND (C.Listbill = ''' + @cListbill + ''' AND C.Timeframe = ' + CONVERT(varchar, @iTimeframe) + ')' + CHAR(13)
    SET @cFilter = @cFilter + '    OR (C.Listbill = ''' + @cListbill + ''' AND C.Timeframe IS NULL)' + CHAR(13)
    SET @cFilter = @cFilter + '    OR (C.Timeframe = ' + CONVERT(varchar, @iTimeframe) + ' AND Listbill IS NULL))' + CHAR(13)
  END
  ELSE
    SET @cFilter = @cFilter + ')' + CHAR(13)

  SET @cSQL = 'SELECT DISTINCT A.[ID],' + CHAR(13)
     + '  A.Name,' + CHAR(13)
     + '  A.Acronym,' + CHAR(13)
     + '  A.Description,' + CHAR(13)
     + '  Display = A.Name + '' - '' + A.Acronym' + CHAR(13)
     + 'FROM (SELECT [ID],' + CHAR(13)
     + '        Name,' + CHAR(13)
     + '        Acronym,' + CHAR(13)
     + '        Description,' + CHAR(13)
     + '        Conditional' + CHAR(13)
     + '      FROM dbo.AvailableReports' + CHAR(13)
     + '      WHERE Product = ' + CONVERT(varchar, @iProduct) + CHAR(13)
     + '        AND Available = 1) A' + CHAR(13)
     + '  LEFT JOIN dbo.ConditionalReports C' + CHAR(13)
     + '    ON C.ReportID = A.ID' + CHAR(13)
     + @cFilter
     + 'ORDER BY A.Name'

  EXEC (@cSQL)

END --CREATE PROCEDURE [dbo].[plsp_GetRequestableReports]
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetReportsByFamily]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetReportsByFamily]

/***********************************************************************************************************
** Name            : plsp_GetAvailableReports.SQL 
** Description     : Returns all available reports sorted by product family.
** Author          : John Stegall
** 
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      08/07/03    John S      Intial Development
**      10/01/2003  MikeT       Script and add to VSS
**      10/09/2003  MikeT       grant execute 
**      06/01/2004  MikeT       Prefix table names with dbo.
**
**
***********************************************************************************************************/ 

@iProduct varchar(10) = null,
@bActive bit = null

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL    varchar(1000),
          @cFilter varchar(100)

  IF(@iProduct IS NOT NULL)
  BEGIN

    SET @cFilter = 'WHERE Product = ' + CONVERT(varchar, @iProduct) + CHAR(13)
  
    IF (@bActive IS NOT NULL)
      SET @cFilter = @cFilter + '  AND Available = ' + CONVERT(varchar, @bActive) + CHAR(13)

  END
  ELSE
  BEGIN
    SET @cFilter = ''
    IF (@bActive IS NOT NULL)
      SET @cFilter = 'WHERE Available = ' + CONVERT(varchar, @bActive) + CHAR(13)
  END

  SET @cSQL = 'SELECT [ID],' + CHAR(13)
    + '  FamilyDisplay = ''('' + (SELECT Description FROM Upkeep WHERE Category = ''Product Family'' AND ItemValue = Product) + '') '' + [Name]' + CHAR(13)
    + 'FROM dbo.AvailableReports' + CHAR(13)
    + @cFilter
    + 'ORDER BY FamilyDisplay'

  EXEC (@cSQL)

END     --CREATE PROCEDURE [dbo].[plsp_GetReportsByFamily]
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetConditionalReports]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetConditionalReports]

/*******************************************************************************
* Description : Retrieves a list of reports to be displayed for the given listbill..
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      04/19/03    John S      Intial Development
*      10/28/03    MikeT       Script and add to VSS
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@cListbill varchar(10) = null,
@iTimeframe int = null

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(4000),
                    @cFilter varchar(1000)

  IF (@cListbill IS NOT NULL)
  BEGIN
    SET @cFilter = 'WHERE (C.Listbill = ''' + @cListbill + ''' AND C.Timeframe IS NULL)' + CHAR(13)

    IF (@iTimeframe IS NOT NULL)
    BEGIN
      SET @cFilter = @cFilter + '  OR (C.Listbill = ''' + @cListbill + ''' AND C.Timeframe = ' + CONVERT(varchar, @iTimeframe) + ')' + CHAR(13)
      SET @cFilter = @cFilter + '  OR (C.Timeframe = ' + CONVERT(varchar, @iTimeframe) + ' AND Listbill IS NULL)' + CHAR(13)
    END
  END
  ELSE IF (@iTimeframe IS NOT NULL)
      SET @cFilter = 'WHERE (C.Timeframe = ' + CONVERT(varchar, @iTimeframe) + ' AND Listbill IS NULL)' + CHAR(13)

  SET @cSQL = 'SELECT C.ReportID,' + CHAR(13)
     + '  C.Timeframe,' + CHAR(13)
     + '  C.Listbill,' + CHAR(13)
     + '  A.Name,' + CHAR(13)
     + '  A.Acronym,' + CHAR(13)
     + '  A.Description,' + CHAR(13)
     + '  Display = A.Name + '' - '' + A.Acronym' + CHAR(13)
     + 'FROM dbo.ConditionalReports C' + CHAR(13)
     + '  JOIN dbo.AvailableReports A' + CHAR(13)
     + '    ON C.ReportID = A.ID' + CHAR(13)
     + @cFilter
     + 'ORDER BY A.Name'

  EXEC (@cSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetAvailableReports]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetAvailableReports]

/***********************************************************************************************************
* Name            : plsp_GetAvailableReports.SQL 
* Description     : Returns all reports for a given product family where the "available" flag
*   is set to 1.
* Author          : John Stegall
* 
* Change Log
*      Date        By          Notes
*      ----------  ----------  ---------------------------------------------------------------------------
*      02/13/03    John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      06/01/2004  MikeT       Prefix table names with dbo.
*
***********************************************************************************************************/ 

@iProduct varchar(10) = null,
@bActive bit = null

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL    varchar(1000),
          @cFilter varchar(100)

  IF(@iProduct IS NOT NULL)
  BEGIN

    SET @cFilter = 'WHERE Product = ' + CONVERT(varchar, @iProduct) + CHAR(13)
  
    IF (@bActive IS NOT NULL)
      SET @cFilter = @cFilter + '  AND Available = ' + CONVERT(varchar, @bActive) + CHAR(13)

  END
  ELSE
  BEGIN
    SET @cFilter = ''
    IF (@bActive IS NOT NULL)
      SET @cFilter = 'WHERE Available = ' + CONVERT(varchar, @bActive) + CHAR(13)
  END

  SET @cSQL = 'SELECT [ID],' + CHAR(13)
    + '  [Name],' + CHAR(13)
    + '  Acronym,' + CHAR(13)
    + '  [Description],' + CHAR(13)
    + '  Display = [Name] + ''('' + Acronym + '')''' + CHAR(13)
    + 'FROM dbo.AvailableReports' + CHAR(13)
    + @cFilter
    + 'ORDER BY [Name]'

  EXEC (@cSQL)
END
GO
/****** Object:  StoredProcedure [dbo].[plsp_DeleteRequest]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_DeleteRequest]

/*******************************************************************************
* Description : Marks a request as "inactive" which causes it to no
*   longer show up on the web pages, making it look deleted.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      06/02/03    John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      05/28/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@iRequestID int = null,
@cListbill varchar(10) = null,
@iStatus int

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(1000),
                    @cFilter varchar(100)

  SET @cFilter = '   WHERE Status = ' + CONVERT(varchar, @iStatus)

  IF (@iRequestID IS NOT NULL)
    SET @cFilter = @cFilter + '     AND [ID] = ' + CONVERT(varchar, @iRequestID) + CHAR(13)
  ELSE IF (@cListbill IS NOT NULL)
    SET @cFilter = @cFilter + '     AND Listbill = ''' + @cListbill + '''' + CHAR(13)

  SET @cSQL = 'UPDATE' + CHAR(13)
    + 'dbo.Requests' + CHAR(13)
    + 'SET Status = 4,'
    + 'Submitted = ''' + CONVERT(varchar, GETDATE(), 101) + '''' + CHAR(13)
    + @cFilter

  EXEC (@cSQL)

END --CREATE PROCEDURE [dbo].[plsp_DeleteRequest]
GO
/****** Object:  StoredProcedure [dbo].[plsp_DeleteReports]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_DeleteReports]

/*******************************************************************************
* Description : Deletes all reports associated with a specific request.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      06/02/03    John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      05/28/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@iRequest int,
@bHistoric bit

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(1000),
                    @cTable varchar(100)

  IF (@bHistoric = 1)
    SET @cTable = 'dbo.HistoryReports'
  ELSE
    SET @cTable = 'dbo.RequestedReports'

  SET @cSQL = 'DELETE' + CHAR(13)
    + 'FROM ' + @cTable + CHAR(13)
    + 'WHERE RequestID = ' + CONVERT(varchar, @iRequest)

  EXEC (@cSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_AddReport]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_AddReport]

/*******************************************************************************
* Description : Adds a report to an existing request.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      02/13/03    John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      05/28/2004  MikeT       Prefix table names with "dbo."
*
*******************************************************************************/

@iRequestID int,
@iReportID int,
@bHistoric bit

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @cSQL varchar(1000),
                    @cTable varchar(100)

  IF (@bHistoric = 1)
    SET @cTable = 'dbo.HistoryReports'
  ELSE
    SET @cTable = 'dbo.RequestedReports'

  SET @cSQL = 'INSERT INTO ' + @cTable + CHAR(13)
    + '  (RequestID,' + CHAR(13)
    + '  ReportID)' + CHAR(13)
    + 'VALUES (' + CONVERT(varchar, @iRequestID) + ',' + CHAR(13)
    + '  ' + CONVERT(varchar, @iReportID) + ')'

  EXEC (@cSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[PLSP_WatchProcessLog]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLSP_WatchProcessLog]

/***********************************************************************************************************
** Name            : PLSP_WatchProcessLog.SQL 
** Description     : Gets top 100 processlog rows for testing
** Author          : Mike Tarrant
** 
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      09/01/2005    MikeT       Intial Dev
**
**
***********************************************************************************************************/ 



AS
BEGIN
     SET NOCOUNT ON


     select top 100 * 
     from processlog 
     where description not like 'System.DirectoryServices.Bind%' 
     order by 1 desc



END --CREATE PROCEDURE [dbo].[PLSP_WatchProcessLog]
GO
/****** Object:  StoredProcedure [dbo].[plsp_DeleteBackDatedRequest]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/************************************************************************
**  Stored Procedure: [dbo]. [plsp_DeleteBackDatedRequest]
**  Creation Date: 2009.07.27
**  Written By: Christopher Rhodes
**  Copyright: Pacific Life
**
**  Desc:
**		Deletes back dated requests.
**
**  Called By:
**		EAC MultiCaseReporting
**
**  Parameters: 
**		RequestID
**
**  Usage:         
**  
**  Calls:          
**
*************************************************************************
**  Change History
*************************************************************************
**  Mod#: Date:         Author:      Description:
**  ----- -----------   -------      ---------------------------------
** **[ENTER DESCRIPTIVE (YET SHORT) VERSION CHANGES]**
************************************************************************/

CREATE PROCEDURE [dbo].[plsp_DeleteBackDatedRequest] 
	@requestID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

BEGIN TRAN

Delete	RequestedReports
From	RequestedReports rr
Where	rr.requestid = @requestID

Delete	RequestInstance
From	RequestInstance ri
Where	ri.requestid = @requestID

Delete	ReportArchive
From	ReportArchive ra
Where	ra.requestid = @requestID

Delete	HistoryReports
From	HistoryReports hr
Join	RequestHistory rh on hr.historyId = rh.id
Where	rh.requestID = @requestID

Delete	RequestHistory
From	RequestHistory rh
Where	rh.requestID = @requestID

Delete	Requests
From	Requests r
Where	r.id = @requestId

COMMIT

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_UnpublishReport]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_UnpublishReport]

/*******************************************************************************
* Description : Unpublishes a report that's been published,
*   provided the report isn't in a "Deleted" status.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      07/14/2003  John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@iFileNetID int

AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.ReportArchive
  SET Status = 2
  WHERE FileNetID = @iFileNetID
    AND Status = 1

  SELECT @@RowCount
END     --CREATE PROCEDURE [dbo].[plsp_UnpublishReport]
GO
/****** Object:  StoredProcedure [dbo].[plsp_PublishReport]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_PublishReport]

/*******************************************************************************
* Description : Adds a record to ReportArchive of a newly published
*   report..
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      07/14/2003  John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      08/11/2004  John S      Made Status a variable (from static '1')
*
*******************************************************************************/

@iFileNetID int,
@iRequestID int,
@iReportID int,
@dPeriodStart datetime,
@dPeriodEnd datetime,
@dProduced datetime,
@iFormat int,
@iStatus int = null

AS
BEGIN
  SET NOCOUNT ON

  if (@iStatus is null)
    SET @iStatus = 1

  INSERT INTO ReportArchive
  VALUES (@iFileNetID,
    @iRequestID,
    @iReportID,
    @dPeriodStart,
    @dPeriodEnd,
     cast(Convert(VARCHAR(10),@dProduced, 120) as datetime),
    @iStatus,
    @iFormat)

  SELECT @@RowCount
END
GO
/****** Object:  StoredProcedure [dbo].[plsp_RepublishReport]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_RepublishReport]

/*******************************************************************************
* Description : Republishes a report that's been unpublished,
*   provided the report isn't in a "Deleted" status.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      07/14/2003  John S      Intial Development
*      09/30/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*      10/01/2004  John S      Added the status of "New" (4) to the query
*
*******************************************************************************/

@iFileNetID int

AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.ReportArchive
  SET Status = 1
  WHERE FileNetID = @iFileNetID
    AND Status IN (2, 4)

  SELECT @@RowCount
END --CREATE PROCEDURE [dbo].[plsp_RepublishReport]
GO
/****** Object:  StoredProcedure [dbo].[plsp_KillReport]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_KillReport]

/*******************************************************************************
* Description : Deletes a report from FileNet that's never been
*   "published" and has no indexes.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      10/11/2004  John S      Intial Development
*
*******************************************************************************/

@iFileNetID int

AS
BEGIN
  SET NOCOUNT ON

  DELETE
  FROM ReportArchive
  WHERE FileNetID = @iFileNetID
    AND Status = 4

  SELECT @@RowCount
END
GO
/****** Object:  StoredProcedure [dbo].[plsp_ForgetReport]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_ForgetReport]

/*******************************************************************************
* Description : "Deletes" a report that's been unpublished,
*   provided the report isn't published.  This makes the report
*   invisible unless deleted reports are being explicity looked for.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      07/14/2003  John S      Intial Development
*      09/30/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@iFileNetID int

AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.ReportArchive
  SET Status = 3
  WHERE FileNetID = @iFileNetID
    AND Status = 2

  SELECT @@RowCount
END --CREATE PROCEDURE [dbo].[plsp_ForgetReport]
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetPublishedReports]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[plsp_GetPublishedReports]

/*******************************************************************************
* Description : Gets all reports that have been "published".
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      05/12/2003  John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@cListBill  varchar(10)

AS
BEGIN
  SET NOCOUNT ON

  SELECT RA.FileNetID,
    AR.Name,
    Frequency = (SELECT [Description] FROM Upkeep WHERE Category = 'Frequency' AND ItemValue = R.Frequency),
    Timeframe = (SELECT [Description] FROM Upkeep WHERE Category = 'Timeframe' AND ItemValue = R.Timeframe),
    RA.PeriodStart,
    RA.PeriodEnd,
    cast(Convert(VARCHAR(10),RA.Produced, 120) as datetime) AS Produced,
    Format = URF.Description
  INTO #PublishedReports
  FROM dbo.ReportArchive RA
    JOIN dbo.Requests R
      ON RA.RequestID = R.ID
    JOIN dbo.AvailableReports AR
      ON RA.ReportID = AR.ID
    JOIN dbo.Upkeep URF
      ON RA.Format = URF.ItemValue
      AND URF.Category = 'File Format'
  WHERE RA.Status = 1
    AND R.Listbill = @cListBill
  ORDER BY R.PeriodEnd,
    RA.Produced DESC,
    Name ASC
 
  SELECT Name,
    Frequency,
    Timeframe,
    PeriodStart,
    PeriodEnd,
    Produced,
    Printable = MAX(ISNULL(
      CASE Format
        WHEN ('HTML') THEN Format
        WHEN ('PDF') THEN Format
      END, '')),
    PrintableID = MAX(ISNULL(
      CASE Format
        WHEN ('HTML') THEN FileNetID
        WHEN ('PDF') THEN FileNetID
      END, 0)),
    Downloadable = MAX(ISNULL(
      CASE Format
        WHEN ('Excel') THEN Format
        WHEN ('Text') THEN Format
        WHEN ('DIF') THEN Format
      END, '')),
    DownloadableID = MAX(ISNULL(
      CASE Format
        WHEN ('Excel') THEN FileNetID
        WHEN ('Text') THEN FileNetID
        WHEN ('DIF') THEN FileNetID
      END, ''))
  FROM #PublishedReports
  GROUP BY Name,
    Frequency,
    Timeframe,
    PeriodStart,
    PeriodEnd,
    Produced
  ORDER BY PeriodEnd,
    Produced DESC,
    Name ASC

  DROP TABLE #PublishedReports

END             --CREATE PROCEDURE [dbo].[plsp_GetPublishedReports]
GO
/****** Object:  StoredProcedure [dbo].[plsp_UpdateRequest]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_UpdateRequest]

/*******************************************************************************
* Description : Updates a request.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      06/02/03    John S      Intial Development
*      09/30/03    MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute
*      12/29/2003  John S      Fix for Timeframe/Frequency updates and made it
*                              return the new request ID
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*      07/27/2004  John S      Switched Status/AssumePremiums order
*******************************************************************************/

@iRequestID int,
@cRequestor varchar(25),
@cOffice varchar(10) = null,
@iFrequency int = null,
@iTimeframe int = null,
@dPeriodStart varchar(25) = null,
@dPeriodEnd varchar(25) = null,
@bAssumePremiums int = null,
@iStatus int = null

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @SQL varchar(1000),
          @Filter varchar(500),
          @CurrentFrequency int,
          @CurrentTimeframe int,
          @NewRequestID int,
          @NewHistoryID int

  --Default the request to be updated as the passed in request
  SELECT @NewRequestID = @iRequestID

  --Get the current frequency and timeframe for the request
  SELECT @CurrentFrequency = Frequency,
    @CurrentTimeframe = Timeframe
  FROM dbo.Requests
  WHERE [ID] = @iRequestID

  SET @Filter = 'Requestor = ''' + @cRequestor + '''' + CHAR(13)
    + ', Submitted = ''' + CONVERT(varchar, GETDATE(), 101) + '''' + CHAR(13)

  IF (@cOffice IS NOT NULL)
    SET @Filter = @Filter + ', Office = ''' + @cOffice + '''' + CHAR(13)

  IF (@iStatus IS NOT NULL)
    SET @Filter = @Filter + ', Status = ' + CONVERT(varchar, @iStatus) + CHAR(13)

  IF (@iFrequency IS NOT NULL)
    SET @Filter = @Filter + ', Frequency = ' + CONVERT(varchar, @iFrequency) + CHAR(13)

  IF (@iTimeframe IS NOT NULL)
    SET @Filter = @Filter + ', Timeframe = ' + CONVERT(varchar, @iTimeframe) + CHAR(13)

  IF (@dPeriodStart IS NOT NULL)
    SET @Filter = @Filter + ', PeriodStart = ''' + @dPeriodStart + '''' + CHAR(13)

  IF (@dPeriodEnd IS NOT NULL)
    SET @Filter = @Filter + ', PeriodEnd = ''' + @dPeriodEnd + '''' + CHAR(13)

  IF (@bAssumePremiums IS NOT NULL)
    SET @Filter = @Filter + ', AssumePremiumsPaid = ' + CONVERT(varchar, @bAssumePremiums) + CHAR(13)

  /****************************************************************************
  * By changing a request's frequency or timeframe, all reports
  * attached to that request will no longer be visible.  To get around
  * this issue, copy the old request (giving the copy a new ID) and
  * mark the original request as inactive.  Update the new request.
  ****************************************************************************/
  IF ((@iFrequency <> @CurrentFrequency) OR (@iTimeframe <> @CurrentTimeframe))
  BEGIN
    INSERT INTO Requests
      SELECT Office,
        Listbill,
        Frequency,
        Timeframe,
        PeriodStart,
        PeriodEnd,
        AssumePremiumsPaid,
        Notes,
        Status,
        Requestor,
        Processed,
        Submitted
      FROM dbo.Requests
      WHERE [ID] = @iRequestID

    --The old request was inactivated, update the request to be worked on
    SELECT @NewRequestID = @@IDENTITY

    INSERT INTO RequestedReports
      SELECT RequestID = @NewRequestID,
        ReportID
      FROM dbo.RequestedReports
      WHERE RequestID = @iRequestID

    UPDATE dbo.Requests
    SET Status = 4
    WHERE [ID] = @iRequestID
  END

  SET @SQL = 'UPDATE Requests' + CHAR(13)
    + 'SET ' + @Filter
    + 'WHERE [ID] = ' + CONVERT(varchar, @NewRequestID)

  INSERT INTO dbo.RequestHistory
    SELECT RequestID = [ID],
      Frequency,
      Timeframe,
      PeriodStart,
      PeriodEnd,
      Status,
      AssumePremiumsPaid,
      UpdatedBy = @cRequestor,
      DateChanged = CONVERT(varchar, GETDATE(), 101)
    FROM dbo.Requests
    WHERE [ID] = @iRequestID

  SELECT @NewHistoryID = @@IDENTITY

  INSERT INTO dbo.HistoryReports
    SELECT HistoryID = @NewHistoryID,
      ReportID
    FROM dbo.RequestedReports
    WHERE RequestID = @iRequestID

  EXEC (@SQL)

  SELECT @NewRequestID
END --CREATE PROCEDURE [dbo].[plsp_UpdateRequest]
GO
/****** Object:  StoredProcedure [dbo].[plsp_EAI_CreateRequest_Policy]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Christopher Rhodes
-- Create date: 2009.04.30
-- Description:	Creates records for MCR 
--              Policy level requests
-- =============================================
CREATE PROCEDURE [dbo].[plsp_EAI_CreateRequest_Policy] 
    @Office VARCHAR(10),
	@Policy VARCHAR(10),
    @Start VARCHAR(10),
    @End VARCHAR(10),
    @Assume VARCHAR(1)
AS
BEGIN
DECLARE @RequestID INT,
        @InstanceID INT

BEGIN TRAN

INSERT INTO dbo.Requests
    (Office,
    Listbill,
    Frequency,
    Timeframe,
    PeriodStart,
    PeriodEnd,
    AssumePremiumsPaid,
    Notes,
    Status,
    Requestor,
    Submitted,
    Processed)
VALUES
   (@Office,
    @Policy,
    7,
    4,
    @Start,
    @End,
    @Assume,
    '',
    3,
    'MCR Fat Client',
    CONVERT(VARCHAR, GETDATE(), 101),
	 '1900-01-01')
--     CONVERT(VARCHAR, GETDATE(), 101))

SET @RequestID = @@IDENTITY

INSERT INTO dbo.RequestInstance
   (RequestId,
    PeriodStart,
    PeriodEnd,
    Created)
VALUES
   (@RequestID,
    @Start,
    @End,
    GETDATE())

SET @InstanceID = @@IDENTITY

COMMIT

SELECT @RequestID,@InstanceID

END
GO
/****** Object:  StoredProcedure [dbo].[PLSP_GetReports2Gen]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLSP_GetReports2Gen]

/***********************************************************************************************************
** Name            : PLSP_GetReports2Gen.SQL 
** Description     : Used by ReportGenerator to get data need to gen reports.
** Author          : Mike Tarrant
** 
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      08/21/2003  MikeT       Intial Dev
**      10/09/2003  MikeT       grant execute 
**      03/03/2004  MikeT       Add AssumePremiumsPaid to output
**	    04/12/2004  MikeT       Filter to only Automated = true.
**      06/01/2004  MikeT       Prefix table names with dbo.
**
**
***********************************************************************************************************/ 


      @InstanceID   int


AS
BEGIN
    SET NOCOUNT ON

    SELECT    ListBill     = r.ListBill
            , PeriodStart  = i.PeriodStart
            , PeriodEnd    = i.PeriodEnd
            , Product      = p.Product
            , r.AssumePremiumsPaid
    FROM dbo.RequestInstance i 
         JOIN dbo.Requests r ON i.RequestID = r.ID
         JOIN ( 
                 SELECT TOP 1 Product, i.InstanceID
                 FROM dbo.RequestInstance i
                     JOIN dbo.Requests r          ON i.RequestID = r.Id
                     JOIN dbo.RequestedReports rr ON r.ID = rr.RequestID
                     JOIN dbo.AvailableReports a  ON rr.ReportID = a.ID
                 WHERE i.InstanceID = @InstanceID
               ) p       ON p.InstanceID = i.InstanceID
    WHERE i.InstanceID = @InstanceID 
    

    SELECT  ReportID
    FROM    dbo.RequestInstance i 
            JOIN dbo.Requests r             ON i.RequestID = r.ID
            JOIN dbo.RequestedReports rr    ON r.ID = rr.RequestID 
            JOIN dbo.AvailableReports ar    ON rr.ReportID = ar.ID AND ar.Automated = 1
    WHERE   i.InstanceID = @InstanceID            





END --CREATE PROCEDURE [dbo].[PLSP_GetReports2Gen]
GO
/****** Object:  StoredProcedure [dbo].[plsp_EAI_CreateRequest]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================================
-- Author:		Christopher Rhodes
-- Create date: 2009.05.06
-- Description:	Creates records for MCR requests
--              
-- Notes:		
--	The Requests table only contains columns for Office and Listbill.
--	The Listbill column will hold Policy, Office, SAID, or Listbill info.
-- ======================================================================

CREATE PROCEDURE [dbo].[plsp_EAI_CreateRequest]

@Office	   VARCHAR(10),
@ListBill  VARCHAR(10),
@Start     VARCHAR(10),
@End       VARCHAR(10),
@Assume	   VARCHAR(1)

AS

DECLARE @RequestID INT,
        @InstanceID INT

BEGIN TRAN

  INSERT INTO dbo.Requests
    (Office,
     Listbill,
     Frequency,
     Timeframe,
     PeriodStart,
     PeriodEnd,
     AssumePremiumsPaid,
     Notes,
     Status,
     Requestor,
     Submitted,
     Processed)
  VALUES
    (@Office,
     @ListBill,
     7,
     4,
     @Start,
     @End,
     @Assume,
     '',
     3,
     'MCR EAC Client',
     CONVERT(VARCHAR, GETDATE(), 101),
	 '1900-01-01')
--     CONVERT(VARCHAR, GETDATE(), 101))

  SET @RequestID = @@IDENTITY

  INSERT INTO dbo.RequestInstance
    (RequestId,
     PeriodStart,
     PeriodEnd,
     Created)
  VALUES
    (@RequestID,
     @Start,
     @End,
     GETDATE())
  SET @InstanceID = @@IDENTITY

COMMIT

SELECT @RequestID, @InstanceID
GO
/****** Object:  StoredProcedure [dbo].[plsp_EAI_CreateRequest_Listbill]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Christopher Rhodes
-- Create date: 2009.05.01
-- Description:	Creates records for MCR 
--              Listbill level requests
-- =============================================

CREATE PROCEDURE [dbo].[plsp_EAI_CreateRequest_Listbill]

@Office	   VARCHAR(10),
@ListBill  VARCHAR(10),
@Start     VARCHAR(10),
@End       VARCHAR(10),
@Assume	   VARCHAR(1)

AS

--SET NOCOUNT ON

DECLARE @RequestID INT,
        @InstanceID INT

BEGIN TRAN

  INSERT INTO dbo.Requests
    (Office,
     Listbill,
     Frequency,
     Timeframe,
     PeriodStart,
     PeriodEnd,
     AssumePremiumsPaid,
     Notes,
     Status,
     Requestor,
     Submitted,
     Processed)
  VALUES
    (@Office,
     @ListBill,
     7,
     4,
     @Start,
     @End,
     @Assume,
     '',
     3,
     'MCR Fat Client',
     CONVERT(VARCHAR, GETDATE(), 101),
	 '1900-01-01')
--     CONVERT(VARCHAR, GETDATE(), 101))

  SET @RequestID = @@IDENTITY

  INSERT INTO dbo.RequestInstance
    (RequestId,
     PeriodStart,
     PeriodEnd,
     Created)
  VALUES
    (@RequestID,
     @Start,
     @End,
     GETDATE())
  SET @InstanceID = @@IDENTITY

COMMIT

SELECT @RequestID, @InstanceID
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetInstanceID]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetInstanceID]

/***********************************************************************************************************
* Name            : plsp_GetInstanceID.SQL 
* Description     : Gets the instance id for a given request and period.
* Author          : John Stegall
* 
* Change Log
*      Date        By          Notes
*      ----------  ----------  ---------------------------------------------------------------------------
*      07/15/03    John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
***********************************************************************************************************/ 

@iRequestID int,
@dStart datetime,
@dEnd datetime,
@InstanceID int output

AS
BEGIN
  SET NOCOUNT ON

  SELECT TOP 1 @InstanceID = InstanceID
  FROM dbo.RequestInstance
  WHERE RequestID = @iRequestID
    AND PeriodStart = @dStart
    AND PeriodEnd = @dEnd

  SELECT @InstanceID = ISNULL(@InstanceID, 0)

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_EAI_Request_Create]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/************************************************************************
**  Stored Procedure: [dbo]. [plsp_EAI_Request_Create]
**  Creation Date: 2009.05.05
**  Written By: Christopher Rhodes
**  Copyright: Pacific Life
**
**  Desc:   Creates records for MCR requests.
**          Inserts rows into Requests and RequestInstance tables.
**
**  Called By:      MCR (EAC) Client Application
**
**  Parameters: 
**		@Office     - Servicing Office
**		@ListBill   - The Requests table only contains columns for Office and Listbill.
**                    The Listbill column will hold Policy, Office, SAID, or Listbill info.
**		@Start      - Reporting Period Start Date
**		@End        - Reporting Period End Date
**		@Assume     - Assume Premiums paid 
**
**  Usage:
**  
**  Calls:
**
*************************************************************************
**  Change History
*************************************************************************
**  Mod#: Date:         Author:      Description:
**  ----- -----------   -------	     ---------------------------------
**     1   2009.05.29	crhodes		 Added execution grant to MCRAdmin	
************************************************************************/

CREATE PROCEDURE [dbo].[plsp_EAI_Request_Create]

@Office	   VARCHAR(10),
@ListBill  VARCHAR(10),
@Start     VARCHAR(10),
@End       VARCHAR(10),
@Assume	   VARCHAR(1)

AS

DECLARE @RequestID INT,
        @InstanceID INT

BEGIN TRAN

  INSERT INTO dbo.Requests
    (Office,
     Listbill,
     Frequency,
     Timeframe,
     PeriodStart,
     PeriodEnd,
     AssumePremiumsPaid,
     Notes,
     Status,
     Requestor,
     Submitted,
     Processed)
  VALUES
    (@Office,
     @ListBill,
     7,
     4,
     @Start,
     @End,
     @Assume,
     '',
     3,
     'MCR EAC Client',
     CONVERT(VARCHAR, GETDATE(), 101),
	 '1900-01-01')

  SET @RequestID = @@IDENTITY

  INSERT INTO dbo.RequestInstance
    (RequestId,
     PeriodStart,
     PeriodEnd,
     Created)
  VALUES
    (@RequestID,
     @Start,
     @End,
     GETDATE())
  SET @InstanceID = @@IDENTITY

COMMIT

SELECT @RequestID, @InstanceID
GO
/****** Object:  StoredProcedure [dbo].[plsp_CreateInstance]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_CreateInstance]

/***********************************************************************************************************
* Name            : plsp_CreateInstance.SQL 
* Description     : Creates an instance id for a given request and period.
* Author          : John Stegall
* 
* Change Log
*      Date        By          Notes
*      ----------  ----------  ---------------------------------------------------------------------------
*      01/07/03    John S      Intial Development
*      03/25/04    MikeT       Populate new column Created when inserting.
*      05/28/04    MikeT       Prefix table names with "dbo."
*
***********************************************************************************************************/ 

@iRequestID int,
@dStart datetime,
@dEnd datetime

AS
BEGIN
  SET NOCOUNT ON

  INSERT INTO dbo.RequestInstance
    (RequestID,
     PeriodStart,
     PeriodEnd,
     Created)
  VALUES (@iRequestID,
    @dStart,
    @dEnd,
    GETDATE())

  SELECT @@IDENTITY

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GenerateBackDatedRequestReport]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/************************************************************************
**  Stored Procedure: [dbo].[plsp_GenerateBackDatedRequestReport]
**  Creation Date: 2009.07.27
**  Written By: Christopher Rhodes
**  Copyright: Pacific Life
**
**  Desc:
**		Generates list of back dated requests.
**
**  Called By:
**		EAC MultiCaseReporting
**
**  Parameters: 
**
**  Usage:         
**  
**  Calls:          
**
*************************************************************************
**  Change History
*************************************************************************
**  Mod#: Date:         Author:      Description:
**  ----- -----------   -------      ---------------------------------
** **[ENTER DESCRIPTIVE (YET SHORT) VERSION CHANGES]**
************************************************************************/
CREATE PROCEDURE [dbo].[plsp_GenerateBackDatedRequestReport] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

declare @r table (i int, reports varchar(100))
declare @reports varchar(100), @i int


declare r cursor READ_ONLY for
	select	RequestID   =    ID          
    from	requests r 
	join	Upkeep uk on r.status = uk.itemvalue
    where	uk.Category = 'Request Status' and uk.Description = 'Back-dated'
    order by listbill

OPEN r
FETCH NEXT FROM r into @i
WHILE @@FETCH_STATUS = 0
BEGIN
	set @reports = null
    select @reports= coalesce(@reports + ', ' , '') + convert(varchar(2),Acronym )
    from requestedreports rr
    join availablereports ar on rr.reportid = ar.id
    where requestid = @i
        
    insert @r values(@i, @reports)
        
	FETCH NEXT FROM r into @i
END
CLOSE r
DEALLOCATE r

select 
  RequestID   =    ID          
, Status      =    uk.description 
, ListBill    =    ListBill   
, Frequency   =    uk1.description   
, Timeframe   =    uk2.description   
, PeriodStart =    convert(varchar,PeriodStart, 101)
, PeriodEnd   =    convert(varchar,PeriodEnd, 101)                                              
, reports     =    rp.reports
from requests rq
	join @r rp on rq.id = rp.i
	join Upkeep uk on rq.status = uk.itemvalue
	join upkeep uk1 on rq.Frequency = uk1.itemvalue
	join upkeep uk2 on rq.timeframe = uk2.itemvalue
where uk.Category = 'Request Status' and uk.Description = 'Back-dated'
and uk1.category = 'Frequency' and uk2.category = 'Timeframe'
order by listbill
END
GO
/****** Object:  StoredProcedure [dbo].[plsp_ReportExists]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_ReportExists]

/*******************************************************************************
* Description : Checks to see if a report already exists in a given
*  request.  If so, it returns 'true', otherwise it returns 'false'.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      05/27/2003  John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@iRequestID int,
@iReportID int

AS
BEGIN
  SET NOCOUNT ON

  SELECT ReportExists =
    CASE Count(ReportID)
      WHEN 0 THEN 'false'
      ELSE 'true'
    END
  FROM dbo.RequestedReports
  WHERE RequestID = @iRequestID
    AND ReportID = @iReportID

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetReportTypeByRequestID]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetReportTypeByRequestID]

/*******************************************************************************
* Description : Gets all the reports to generate for this request, using a
*   given RequestID.
* 
* Change Log
*
*      Date        By				Notes
*      ----------  --------------	------------------------------------------------
*      11/02/2009  Perry Fortier    Initial Development
*
*******************************************************************************/

@iRequestID int = null

AS
BEGIN
	
	SET NOCOUNT ON

	SELECT	dbo.AvailableReports.Acronym 
		FROM dbo.RequestedReports LEFT JOIN dbo.AvailableReports 
		ON dbo.AvailableReports.ID = dbo.RequestedReports.ReportID
	WHERE dbo.RequestedReports.RequestID = 134
	ORDER BY Acronym

  
END         --CREATE PROCEDURE [dbo].[plsp_GetReportTypeByRequestID]
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetReportAcronym]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetReportAcronym]

/********************************************************************************
* Description : This stored procedure gets reports Acronym for a given RequestID
*       Input : RequestID 
*   Creatd on : 2/25/2010  
*       Usage : plsp_GetReportAcronym 6286
********************************************************************************/

@RequestID int

AS
BEGIN
	SELECT Acronym 
	  FROM RequestedReports rr
		   jOIN AvailableReports ar ON (rr.ReportID = ar.ID AND ar.Automated = 1)
	WHERE rr.RequestID = @RequestID

END
GO
/****** Object:  StoredProcedure [dbo].[PLSP_GetLog_Reporting]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLSP_GetLog_Reporting]

/***********************************************************************************************************
** Name            : PLSP_GetLog.SQL
** Description     : This is a Stored Procedure
** Author          : Mike Tarrant
**
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      09/09/03    MikeT       Intial Dev
**      09/26/03    MikeT       Change SuperSet to SuperSQL
**      10/09/03    MikeT       grant execute
**      10/20/03    MikeT       Add new parameters (@iSource & @cViewer)
**                              and allow for change MCRRequest.Processlog structure.
**      10/23/03    MikeT       Allow for source is now varchar(250) vs int
**      11/27/03    MikeT       ReWrite for new requirments.
**      02/17/04    MikeT       Change sort order
**                                  from:     ORDER BY  t.Occurrence asc ,  t.listbill asc, t.instanceid asc, t.orderby
**                                  to:       ORDER BY  t.listbill asc, t.instanceid asc, t.Occurrence asc , t.orderby
**      02/18/04    MikeT       Filter out records. "Description NOT LIKE  '%DO NOT INCLUDE' "
**      02/19/04    MikeT       Policy count was filtering out failed reports. Changed to use a LEFT JOIN to
**                              prevent this.
**      06/01/2004  MikeT       Prefix table names with dbo.
**      09/15/2004  MikeT       Adjustments to allow for Success now being a int vs a bit
**      01/26/2005  MikeT       Sort by Product 1st
**      08/27/2008  MikeT       Allow for request recieved by EAI
**      09/15/2008  MikeT       Fix records that don't get marked complete that should be.
**      09/18/2008  MikeT       rollback fix records in the log trigger instead
**
**
***********************************************************************************************************/



/*


      @cListBill      varchar(10) = null
    , @cOffice        varchar(10) = null
    , @iProductFamily int         = null
    , @dBegin         datetime    = null
    , @dEnd           datetime    = null
    , @iTimeframe     int         = null
    , @iFrequency     int         = null
    , @iReport        int         = null
    , @cSource        varchar(250)= null
    , @cViewer        varchar(5)  = null

*/
      @dProcessStart  datetime    = null
    , @dProcessEnd    datetime    = null


AS
BEGIN
    
    DECLARE @LastReport datetime
    
	--SET @dProcessStart = '08/02/2010'
	--SET @dProcessEnd = '08/03/2010'
	
    SELECT @LastReport = MAX(ReportEnd) FROM PEReport

    IF(@dProcessStart is null)
    BEGIN
        SELECT @dProcessStart = @LastReport
    END

    IF(@dProcessEnd is null)
    BEGIN
        SELECT @dProcessEnd = GETDATE()
        INSERT PEReport VALUES (@dProcessEnd)
    END


    --Create a product table to join to
    CREATE TABLE #p (ProductID int, Product char(5))
    INSERT #p VALUES (1, 'VUL')
    INSERT #p VALUES (2, 'UL')
    INSERT #p VALUES (3, 'WL')
   

/*
    UPDATE mcreport.dbo.processlog
    SET description = 'All requested reports generated successfully', success = 1
    WHERE instanceid IN (SELECT instanceid
                         FROM processlog
                         WHERE description = 'Returned from reportgenerator: 1'
                            AND occurrence BETWEEN @dProcessStart and @dProcessEnd
                         )


    UPDATE mcreport.dbo.processlog
    SET description = 'Failure to generate all requested reports', success = 0
    WHERE instanceid IN (SELECT instanceid
                         FROM processlog
                         WHERE description = 'Returned from reportgenerator: 0'
                            AND occurrence BETWEEN @dProcessStart and @dProcessEnd
                         )
*/


--    --Report header
--    SELECT Request = 'Total Request', count = count(*), orderby = 9
--    FROM MCReport.dbo.processlog p
--    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
--    UNION
----    SELECT Request = case success when 1 then 'Successful' else 'Failed' end ,count = count(*), orderby = success
--    SELECT Request = s.description ,count = count(*), orderby = success
--    FROM MCReport.dbo.processlog p
--            JOIN MCReport.dbo.desc_Success s ON p.success = s.successID
--    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
--    GROUP BY success, s.description
--    ORDER BY 3 desc

    declare @r table (i int, reports varchar(100))
    declare @reports varchar(100), @i int


declare r cursor READ_ONLY for
	select	RequestID   =    ID          
    from	requests r 
	where (PeriodStart >= @dProcessStart and PeriodEnd <= @dProcessEnd)
    order by listbill

	OPEN r
	FETCH NEXT FROM r into @i
	WHILE @@FETCH_STATUS = 0
	BEGIN
		set @reports = null
		select @reports= coalesce(@reports + ', ' , '') + convert(varchar(2),Acronym )
		from requestedreports rr
		join availablereports ar on rr.reportid = ar.id
		where requestid = @i
	        
		insert @r values(@i, @reports)
	        
		FETCH NEXT FROM r into @i
	END
    
    SELECT    distinct  
			  orderby = 1
			, Source = 'EAI/Mainframe'
            , p.instanceid
            , p.Listbill
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , Policy_Count = ISNULL(Policy_Count, 0)
            , n.LC_Name
            , #p.Product
            , i.PeriodStart
            , i.PeriodEnd
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , rp.Reports as [Reports Requested]
            , r.Office as [OfficeID]                                                      
			--, notes
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end            
            , r.Requestor
            , r.Frequency
--			, i.RequestID
--          , Severity       = space(20) --ISNULL(ies.Description, '')
--          , Occurrence    = p.ProcessDate
--          , Type          = CASE p.Success WHEN 1 THEN 'Success' WHEN 0 THEN 'Error' ELSE 'In Process' END
            , Description   = p.Description
    INTO #t
    FROM MCReport.dbo.ProcessLog p
      JOIN dbo.requestinstance i       ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r              ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr     ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar     ON rr.ReportID  = ar.ID
      JOIN #p                          ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s ON p.success = s.successID
      left JOIN @r rp on r.id = rp.i
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
     LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND  p.Description NOT LIKE  '%DO NOT INCLUDE'

 SELECT Rows, t.*
    FROM #t t
        JOIN (SELECT  rows = count(*), instanceid FROM #t GROUP BY instanceid) r
            ON t.instanceid = r.instanceid
    ORDER BY  t.Product asc, t.listbill asc, t.instanceid asc, t.orderby

CLOSE r
DEALLOCATE r


/*
--[ START OF COMMENT BLOCK ]--------------------------------------------------------------

    SELECT    orderby = 1
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = space(20) --ISNULL(ies.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = CASE p.Success WHEN 1 THEN 'Success' WHEN 0 THEN 'Error' ELSE 'In Process' END
            , Description   = p.Description
    INTO #t
    FROM MCReport.dbo.ProcessLog p
      JOIN dbo.requestinstance i       ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r              ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr     ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar     ON rr.ReportID  = ar.ID
      JOIN #p                          ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
     LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND  p.Description NOT LIKE  '%DO NOT INCLUDE'

    union

    SELECT    orderby = 2
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = ISNULL(ies.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = iel.ErrType
            , Description   = ISNULL(iel.ErrDesc, '')
    FROM MCReport.dbo.ProcessLog p   JOIN dbo.requestinstance i      ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r               ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr      ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar      ON rr.ReportID  = ar.ID
      JOIN #p                           ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s  ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
      JOIN MCReport.dbo.InstanceErrorLog iel ON p.InstanceID = iel.InstanceID
      JOIN MCReport.dbo.ErrorSeverity  ies   ON iel.Severity = ies.Severity
      LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND iel.ErrDesc NOT LIKE  '%DO NOT INCLUDE'

    union

    SELECT    orderby = 3
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = ISNULL(pes.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = ISNULL(pel.PolNo, '')
            , Description   = ISNULL(pel.ErrDesc, '')
    FROM MCReport.dbo.ProcessLog p   JOIN dbo.requestinstance i      ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r               ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr      ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar      ON rr.ReportID  = ar.ID
      JOIN #p                           ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s  ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
      JOIN MCReport.dbo.PolicyErrorLog pel   ON p.InstanceID = pel.InstanceID
      JOIN MCReport.dbo.ErrorSeverity  pes   ON pel.Severity = pes.Severity
      LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND  pel.ErrDesc NOT LIKE  '%DO NOT INCLUDE'
--[ END OF COMMENT BLOCK ]-------------------------------------------------------------
*/

    
    IF EXISTS(SELECT COUNT(*) FROM #t)
    BEGIN
		drop table #t
	END
	
	IF EXISTS(SELECT COUNT(*) FROM #p)
	BEGIN
		drop table #p
	END
END
GO
/****** Object:  StoredProcedure [dbo].[plsp_PurgeBackDatedRequest]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_PurgeBackDatedRequest] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT	RequestID   =  [ID]
into #IDs      
    from	requests r 
	JOIN	Upkeep uk on r.status = uk.itemvalue
    where	uk.Category = 'Request Status' AND uk.Description = 'Back-dated' AND
			FREQUENCY <> 7 and datediff("M", periodend, getdate() ) >0
    order by listbill

  
BEGIN TRAN

Delete	RequestedReports
From	RequestedReports rr, #IDs IDs
Where	rr.requestid = IDs.RequestID

Delete	RequestInstance
From	RequestInstance ri,#IDs IDs
Where	ri.requestid = IDs.RequestID

Delete	ReportArchive
From	ReportArchive ra, #IDs IDs
Where	ra.requestid = IDs.RequestID

Delete	HistoryReports
From	HistoryReports hr, RequestHistory  rh, #IDs IDs
Where	hr.historyId = rh.id AND rh.requestID = IDs.RequestID 

Delete	RequestHistory
From	RequestHistory rh , #IDs IDs
Where	rh.requestID = IDs.RequestID

Delete	Requests
From	Requests r, #IDs IDs
Where	r.id = IDs.RequestID

COMMIT

drop table #IDs

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_UpdateProcessed]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[plsp_UpdateProcessed]

/*******************************************************************************
* Description : Updates the processed date of a one-time request.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      02/13/03    John S      Intial Development
*      09/03/03    MikeT       Fixed
*      09/15/03    John S      Updated from Frequency to Timeframe
*      03/30/04    John S      Added additional conditions to check for already
*                              generated requests and handling of one-time and
*                              back-dated request processing.
*      06/01/2004  MikeT       Prefix table names with dbo.
*      06/01/2004  Jmensik     Added "SET Submited" to fix the MCR Web filter page
*
*******************************************************************************/

@iRequestID int

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @iStatus int,
          @iFrequency int,
          @dtProcessed datetime,
	      @dtSubmitted datetime 

  SELECT @iStatus = Status,
    	@iFrequency = Frequency,
    	@dtProcessed = Processed,
        @dtSubmitted = Submitted

  FROM dbo.Requests
  WHERE [ID] = @iRequestID

  --Is the request being updated an already generated, back-dated, or one-time request?
  IF (@iStatus = 6)
    --The request is an already generated request, update the processed date and status
    UPDATE dbo.Requests
    SET Processed = CONVERT(varchar, GETDATE(), 101),
        Status = 3,
        Submitted = CONVERT(varchar, GETDATE(), 101)
    WHERE [ID] = @iRequestID

  ELSE 
	IF (@iStatus = 5 OR @iFrequency = 7)
  BEGIN
    --If the back-dated/one-time request has not been processed, update only the
    --processed date.  If it's been processed, set the status to expired.
    IF (@dtProcessed IS NULL)
      UPDATE dbo.Requests
      SET Processed = CONVERT(varchar, GETDATE(), 101),
          Submitted = CONVERT(varchar, GETDATE(), 101) 
      WHERE [ID] = @iRequestID
    ELSE
      UPDATE dbo.Requests
      SET Status = 3,
          Submitted = CONVERT(varchar, GETDATE(), 101) 
      WHERE [ID] = @iRequestID
  END
  ELSE
    -- Since the request is recurring, update the processed date only
    UPDATE dbo.Requests
    SET Processed = CONVERT(varchar, GETDATE(), 101),	
        Submitted = CONVERT(varchar, GETDATE(), 101)
    WHERE [ID] = @iRequestID
END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetOffices]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetOffices]

/*******************************************************************************
* Description: Retrieves all offices with requests.
* 
* Change Log
* 
* Date        By          Notes
* ----------  ----------  ------------------------------------------------------
* 09/24/2003  John S      Intial Development
* 06/01/2004  MikeT       Prefix table names with dbo.
* 06/23/2004  MikeT       Grant Exec
*
*******************************************************************************/

AS
BEGIN
  SET NOCOUNT ON

  SELECT DISTINCT Office
  FROM dbo.Requests
  ORDER BY Office

END --CREATE PROCEDURE [dbo].[plsp_GetOffices]
GO
/****** Object:  StoredProcedure [dbo].[PLSP_UpdateOffices]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLSP_UpdateOffices]

/***********************************************************************************************************
** Name            : PLSP_UpdateOffices.SQL 
** Description     : Updates all requests offices before schedule runs
** Author          : Mike Tarrant
** 
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      04/27/2004  MikeT       Intial Dev
**      06/23/2004  MikeT       Grant Exec
**      04/05/2005  MikeT       Add call to PLSP_PurgeData
**
**
***********************************************************************************************************/ 



AS
BEGIN
     SET NOCOUNT ON


    UPDATE requests  SET office = t.PG_Servicing_Office_Code
    FROM requests r
    JOIN
    (
        SELECT DISTINCT r.*,g.PG_Servicing_Office_Code 
        FROM
            ( 
              SELECT DISTINCT listbill 
              FROM requests
            ) r 
         -- JOIN SuperSQL_RM_Inquiry.dbo.policy_billing b ON r.listbill = b.LC_Listbill_Number
         -- JOIN SuperSQL_RM_Inquiry.dbo.policy_general g ON b.policy_number = g.policy_number
         -- JOIN SuperSQL_RM_Inquiry.dbo.desc_policy_status_code sc ON g.DPOSC_Policy_Status_Code = sc.DPOSC_Policy_Status_Code
         JOIN SuperSQL.dbo.policy_billing b ON r.listbill = b.LC_Listbill_Number
         JOIN SuperSQL.dbo.policy_general g ON b.policy_number = g.policy_number
         JOIN SuperSQL.dbo.desc_policy_status_code sc ON g.DPOSC_Policy_Status_Code = sc.DPOSC_Policy_Status_Code
        WHERE   DPOSC_CAT_Code_DESC = 'INFORCE ACTIVE'
    ) t ON r.listbill = t.listbill


    EXEC [MCReport].[dbo].[PLSP_PurgeData]


END
 --CREATE PROCEDURE [dbo].[PLSP_UpdateOffices]
GO
/****** Object:  StoredProcedure [dbo].[plsp_SaveRequest]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_SaveRequest]

/*******************************************************************************
* Description : Adds a request to any of the Requests tables.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      02/13/03    John S      Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

@cListBill char(10),
@cOffice char(10),
@iFrequency int,
@iTimeframe int,
@dStart datetime,
@dEnd datetime,
@bAssume bit,
@cNotes char(500) = null,
@iStatus int,
@cRequestor varchar(25)

AS
BEGIN
  SET NOCOUNT ON

  INSERT INTO dbo.Requests
    (Office,
     Listbill,
     Frequency,
     Timeframe,
     PeriodStart,
     PeriodEnd,
     AssumePremiumsPaid,
     Notes,
     Status,
     Requestor,
     Submitted)
  VALUES (@cOffice,
    @cListBill,
    @iFrequency,
    @iTimeframe,
    @dStart,
    @dEnd,
    @bAssume,
    @cNotes,
    @iStatus,
    @cRequestor,
    CONVERT(varchar, GETDATE(), 101))

  SELECT @@IDENTITY

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetListbills]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetListbills]

/*******************************************************************************
* Description : Retrieves all listbills with requests.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      04/9/03    John S       Intial Development
*      10/01/2003  MikeT       Script and add to VSS
*      10/09/2003  MikeT       grant execute 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*******************************************************************************/

AS
BEGIN
  SET NOCOUNT ON

  SELECT DISTINCT Listbill
  FROM dbo.Requests
  ORDER BY Listbill

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_Scheduled_PurgeofRequests]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_Scheduled_PurgeofRequests]

/*******************************************************************************
* Description : Deletes a requests and all reports associated with
*   that requests, based on the age of the request
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      05/21/2009  cberke      Intial Development
*
*******************************************************************************/
@lRetentionDays int = NULL 
AS
BEGIN
  SET NOCOUNT ON
  
  IF @lRetentionDays is NULL
  BEGIN
     Set @lRetentionDays = 90
  END 
  DECLARE @PurgeDate as datetime
  set @PurgeDate = DateAdd(day, -1 * @lRetentionDays, CONVERT(datetime, CONVERT(varchar(10), getdate(), 111), 111))
 
   
 Select [ID] as toPurgeRequestID 
  into #PurgeList
  from Requests
  where Submitted < @PurgeDate
  
-- Remove Process Log Information First ---------------------

--  DELETE dbo.CriticalError
--   FROM dbo.CriticalError c
--    join dbo.ProcessLog y on y.[ID] = c.ProcessLogID
--    join dbo.RequestInstance x on x.InstanceID = y.InstanceID
--    join #PurgeList pl on x.RequestID = pl.toPurgeRequestID


  DELETE dbo.ProcessLog
    FROM dbo.ProcessLog y
    join dbo.RequestInstance x on x.InstanceID = y.InstanceID
    join #PurgeList pl on x.RequestID = pl.toPurgeRequestID


-- Remove Request Data ---------------------
  DELETE dbo.HistoryReports
    FROM dbo.HistoryReports y
     join dbo.RequestHistory x on x.[ID] = Y.HistoryID
     JOIN #PurgeList pl on x.RequestID = pl.toPurgeRequestID


  DELETE dbo.RequestHistory
    from dbo.RequestHistory x
    join #PurgeList pl on x.RequestID = pl.toPurgeRequestID
   

  DELETE dbo.RequestedReports
    from dbo.RequestedReports x
    join #PurgeList pl on x.RequestID = pl.toPurgeRequestID


  --DELETE dbo.ReportArchive
  --  from dbo.ReportArchive x
  --  join #PurgeList pl on x.RequestID = pl.toPurgeRequestID

-- Remove Root ParentID Data ---------------------

  DELETE dbo.RequestInstance
    from dbo.RequestInstance x
    join #PurgeList pl on x.RequestID = pl.toPurgeRequestID


END
GO
/****** Object:  StoredProcedure [dbo].[PLSP_LookupReportID]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLSP_LookupReportID]

/***********************************************************************************************************
** Name            : PLSP_LookupReportID.SQL
** Description     : This is a Stored Procedure
** Author          : Mike Tarrant
**
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      06/23/2008    MikeT       Intial Dev
**
**
***********************************************************************************************************/




	  @ReportName varchar(40)
	, @ProductFamily varchar(40)
AS
BEGIN
    SET NOCOUNT ON

    SELECT ReportID = a.id
    FROM dbo.availablereports a
    JOIN dbo.upkeep u ON u.itemvalue = a.product
    WHERE u.category = 'Product Family'
        and u.description = @ProductFamily
        and a.name = @ReportName


END --CREATE PROCEDURE [dbo].[PLSP_LookupReportID]
GO
/****** Object:  StoredProcedure [dbo].[PLSP_GetLog_2]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLSP_GetLog_2]

/***********************************************************************************************************
** Name            : PLSP_GetLog.SQL
** Description     : This is a Stored Procedure
** Author          : Mike Tarrant
**
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      09/09/03    MikeT       Intial Dev
**      09/26/03    MikeT       Change SuperSet to SuperSQL
**      10/09/03    MikeT       grant execute
**      10/20/03    MikeT       Add new parameters (@iSource & @cViewer)
**                              and allow for change MCRRequest.Processlog structure.
**      10/23/03    MikeT       Allow for source is now varchar(250) vs int
**      11/27/03    MikeT       ReWrite for new requirments.
**      02/17/04    MikeT       Change sort order
**                                  from:     ORDER BY  t.Occurrence asc ,  t.listbill asc, t.instanceid asc, t.orderby
**                                  to:       ORDER BY  t.listbill asc, t.instanceid asc, t.Occurrence asc , t.orderby
**      02/18/04    MikeT       Filter out records. "Description NOT LIKE  '%DO NOT INCLUDE' "
**      02/19/04    MikeT       Policy count was filtering out failed reports. Changed to use a LEFT JOIN to
**                              prevent this.
**      06/01/2004  MikeT       Prefix table names with dbo.
**      09/15/2004  MikeT       Adjustments to allow for Success now being a int vs a bit
**      01/26/2005  MikeT       Sort by Product 1st
**      08/27/2008  MikeT       Allow for request recieved by EAI
**      09/15/2008  MikeT       Fix records that don't get marked complete that should be.
**      09/18/2008  MikeT       rollback fix records in the log trigger instead
**
**
***********************************************************************************************************/



/*


      @cListBill      varchar(10) = null
    , @cOffice        varchar(10) = null
    , @iProductFamily int         = null
    , @dBegin         datetime    = null
    , @dEnd           datetime    = null
    , @iTimeframe     int         = null
    , @iFrequency     int         = null
    , @iReport        int         = null
    , @cSource        varchar(250)= null
    , @cViewer        varchar(5)  = null

*/
      @dProcessStart  datetime    = null
    , @dProcessEnd    datetime    = null


AS
BEGIN
    
    DECLARE @LastReport datetime
    
	--SET @dProcessStart = '08/02/2010'
	--SET @dProcessEnd = '08/03/2010'
	
    SELECT @LastReport = MAX(ReportEnd) FROM PEReport

    IF(@dProcessStart is null)
    BEGIN
        SELECT @dProcessStart = @LastReport
    END

    IF(@dProcessEnd is null)
    BEGIN
        SELECT @dProcessEnd = GETDATE()
        INSERT PEReport VALUES (@dProcessEnd)
    END


    --Create a product table to join to
    CREATE TABLE #p (ProductID int, Product char(5))
    INSERT #p VALUES (1, 'VUL')
    INSERT #p VALUES (2, 'UL')
    INSERT #p VALUES (3, 'WL')

/*
    UPDATE mcreport.dbo.processlog
    SET description = 'All requested reports generated successfully', success = 1
    WHERE instanceid IN (SELECT instanceid
                         FROM processlog
                         WHERE description = 'Returned from reportgenerator: 1'
                            AND occurrence BETWEEN @dProcessStart and @dProcessEnd
                         )


    UPDATE mcreport.dbo.processlog
    SET description = 'Failure to generate all requested reports', success = 0
    WHERE instanceid IN (SELECT instanceid
                         FROM processlog
                         WHERE description = 'Returned from reportgenerator: 0'
                            AND occurrence BETWEEN @dProcessStart and @dProcessEnd
                         )
*/


--    --Report header
--    SELECT Request = 'Total Request', count = count(*), orderby = 9
--    FROM MCReport.dbo.processlog p
--    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
--    UNION
----    SELECT Request = case success when 1 then 'Successful' else 'Failed' end ,count = count(*), orderby = success
--    SELECT Request = s.description ,count = count(*), orderby = success
--    FROM MCReport.dbo.processlog p
--            JOIN MCReport.dbo.desc_Success s ON p.success = s.successID
--    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
--    GROUP BY success, s.description
--    ORDER BY 3 desc




    SELECT    orderby = 1
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = space(20) --ISNULL(ies.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = CASE p.Success WHEN 1 THEN 'Success' WHEN 0 THEN 'Error' ELSE 'In Process' END
            , Description   = p.Description
    INTO #t
    FROM MCReport.dbo.ProcessLog p
      JOIN dbo.requestinstance i       ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r              ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr     ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar     ON rr.ReportID  = ar.ID
      JOIN #p                          ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
     LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND  p.Description NOT LIKE  '%DO NOT INCLUDE'

    union

    SELECT    orderby = 2
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = ISNULL(ies.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = iel.ErrType
            , Description   = ISNULL(iel.ErrDesc, '')
    FROM MCReport.dbo.ProcessLog p   JOIN dbo.requestinstance i      ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r               ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr      ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar      ON rr.ReportID  = ar.ID
      JOIN #p                           ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s  ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
      JOIN MCReport.dbo.InstanceErrorLog iel ON p.InstanceID = iel.InstanceID
      JOIN MCReport.dbo.ErrorSeverity  ies   ON iel.Severity = ies.Severity
      LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND iel.ErrDesc NOT LIKE  '%DO NOT INCLUDE'

    union

    SELECT    orderby = 3
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = ISNULL(pes.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = ISNULL(pel.PolNo, '')
            , Description   = ISNULL(pel.ErrDesc, '')
    FROM MCReport.dbo.ProcessLog p   JOIN dbo.requestinstance i      ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r               ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr      ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar      ON rr.ReportID  = ar.ID
      JOIN #p                           ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s  ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
      JOIN MCReport.dbo.PolicyErrorLog pel   ON p.InstanceID = pel.InstanceID
      JOIN MCReport.dbo.ErrorSeverity  pes   ON pel.Severity = pes.Severity
      LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND  pel.ErrDesc NOT LIKE  '%DO NOT INCLUDE'

    SELECT Rows, t.*
    FROM #t t
        JOIN (SELECT  rows = count(*), instanceid FROM #t GROUP BY instanceid) r
            ON t.instanceid = r.instanceid
    ORDER BY  t.Product asc, t.listbill asc, t.instanceid asc, t.Occurrence asc , t.orderby
    
    IF EXISTS(SELECT COUNT(*) FROM #t)
    BEGIN
		drop table #t
	END
	
	IF EXISTS(SELECT COUNT(*) FROM #p)
	BEGIN
		drop table #p
	END
END
GO
/****** Object:  StoredProcedure [dbo].[PLSP_GetLog]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLSP_GetLog]

/***********************************************************************************************************
** Name            : PLSP_GetLog.SQL
** Description     : This is a Stored Procedure
** Author          : Mike Tarrant
**
** Change Log
**      Date        By          Notes
**      ----------  ----------  ---------------------------------------------------------------------------
**      09/09/03    MikeT       Intial Dev
**      09/26/03    MikeT       Change SuperSet to SuperSQL
**      10/09/03    MikeT       grant execute
**      10/20/03    MikeT       Add new parameters (@iSource & @cViewer)
**                              and allow for change MCRRequest.Processlog structure.
**      10/23/03    MikeT       Allow for source is now varchar(250) vs int
**      11/27/03    MikeT       ReWrite for new requirments.
**      02/17/04    MikeT       Change sort order
**                                  from:     ORDER BY  t.Occurrence asc ,  t.listbill asc, t.instanceid asc, t.orderby
**                                  to:       ORDER BY  t.listbill asc, t.instanceid asc, t.Occurrence asc , t.orderby
**      02/18/04    MikeT       Filter out records. "Description NOT LIKE  '%DO NOT INCLUDE' "
**      02/19/04    MikeT       Policy count was filtering out failed reports. Changed to use a LEFT JOIN to
**                              prevent this.
**      06/01/2004  MikeT       Prefix table names with dbo.
**      09/15/2004  MikeT       Adjustments to allow for Success now being a int vs a bit
**      01/26/2005  MikeT       Sort by Product 1st
**      08/27/2008  MikeT       Allow for request recieved by EAI
**      09/15/2008  MikeT       Fix records that don't get marked complete that should be.
**
**
***********************************************************************************************************/



/*


      @cListBill      varchar(10) = null
    , @cOffice        varchar(10) = null
    , @iProductFamily int         = null
    , @dBegin         datetime    = null
    , @dEnd           datetime    = null
    , @iTimeframe     int         = null
    , @iFrequency     int         = null
    , @iReport        int         = null
    , @cSource        varchar(250)= null
    , @cViewer        varchar(5)  = null

*/
      @dProcessStart  datetime    = null
    , @dProcessEnd    datetime    = null


AS
BEGIN
    SET NOCOUNT ON

    DECLARE @LastReport datetime

    SELECT @LastReport = MAX(ReportEnd) FROM PEReport

    IF(@dProcessStart is null)
    BEGIN
        SELECT @dProcessStart = @LastReport
    END

    IF(@dProcessEnd is null)
    BEGIN
        SELECT @dProcessEnd = GETDATE()
        INSERT PEReport VALUES (@dProcessEnd)
    END


    --Create a product table to join to
    CREATE TABLE #p (ProductID int, Product char(5))
    INSERT #p VALUES (1, 'VUL')
    INSERT #p VALUES (2, 'UL')
    INSERT #p VALUES (3, 'WL')


    UPDATE mcreport.dbo.processlog
    SET description = 'All requested reports generated successfully', success = 1
    WHERE instanceid IN (SELECT instanceid
                         FROM processlog
                         WHERE description = 'Returned from reportgenerator: 1'
                            AND occurrence BETWEEN @dProcessStart and @dProcessEnd
                         )


    UPDATE mcreport.dbo.processlog
    SET description = 'Failure to generate all requested reports', success = 0
    WHERE instanceid IN (SELECT instanceid
                         FROM processlog
                         WHERE description = 'Returned from reportgenerator: 0'
                            AND occurrence BETWEEN @dProcessStart and @dProcessEnd
                         )



    --Report header
    SELECT Request = 'Total Request', count = count(*), orderby = 9
    FROM MCReport.dbo.processlog p
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
    UNION
--    SELECT Request = case success when 1 then 'Successful' else 'Failed' end ,count = count(*), orderby = success
    SELECT Request = s.description ,count = count(*), orderby = success
    FROM MCReport.dbo.processlog p
            JOIN MCReport.dbo.desc_Success s ON p.success = s.successID
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
    GROUP BY success, s.description
    ORDER BY 3 desc




    SELECT    orderby = 1
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = space(20) --ISNULL(ies.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = CASE p.Success WHEN 1 THEN 'Success' WHEN 0 THEN 'Error' ELSE 'In Process' END
            , Description   = p.Description
    INTO #t
    FROM MCReport.dbo.ProcessLog p
      JOIN dbo.requestinstance i       ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r              ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr     ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar     ON rr.ReportID  = ar.ID
      JOIN #p                          ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
     LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND  p.Description NOT LIKE  '%DO NOT INCLUDE'

    union

    SELECT    orderby = 2
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = ISNULL(ies.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = iel.ErrType
            , Description   = ISNULL(iel.ErrDesc, '')
    FROM MCReport.dbo.ProcessLog p   JOIN dbo.requestinstance i      ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r               ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr      ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar      ON rr.ReportID  = ar.ID
      JOIN #p                           ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s  ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
      JOIN MCReport.dbo.InstanceErrorLog iel ON p.InstanceID = iel.InstanceID
      JOIN MCReport.dbo.ErrorSeverity  ies   ON iel.Severity = ies.Severity
      LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND iel.ErrDesc NOT LIKE  '%DO NOT INCLUDE'

    union

    SELECT    orderby = 3
	    , Source = 'EAI/Mainframe'
            , p.instanceid
            , i.RequestID
            , Policy_Count = ISNULL(Policy_Count, 0)
            , Status = s.description --CASE p.Success WHEN 1 THEN 'Success' ELSE 'Failed' END
            , notes1 = case len(rtrim(notes)) when 0 then 'N' else 'Y' end
            , #p.Product
            , PI = case AssumePremiumsPaid when 1 then 'Y' else 'N' end
            , p.Listbill
            , Severity       = ISNULL(pes.Description, '')
            , n.LC_Name
            , i.PeriodStart
            , i.PeriodEnd
            , Occurrence    = p.ProcessDate
            , Type          = ISNULL(pel.PolNo, '')
            , Description   = ISNULL(pel.ErrDesc, '')
    FROM MCReport.dbo.ProcessLog p   JOIN dbo.requestinstance i      ON p.InstanceID = i.InstanceID
      JOIN dbo.Requests r               ON i.RequestID  = r.ID
      JOIN dbo.RequestedReports rr      ON r.ID         = rr.RequestID
      JOIN dbo.AvailableReports ar      ON rr.ReportID  = ar.ID
      JOIN #p                           ON ar.Product   = #p.ProductID
      JOIN MCReport.dbo.desc_Success s  ON p.success = s.successID
      LEFT JOIN (SELECT Policy_Count = COUNT(*), InstanceID, Product = 'UL'
            FROM MCReport.dbo.UL
            GROUP BY InstanceID
            UNION
            SELECT Policy_Count = COUNT(*), InstanceID, Product = 'VUL'
            FROM MCReport.dbo.VUL_Policy
            GROUP BY InstanceID  ) u
        ON p.InstanceID = u.InstanceID
      JOIN MCReport.dbo.PolicyErrorLog pel   ON p.InstanceID = pel.InstanceID
      JOIN MCReport.dbo.ErrorSeverity  pes   ON pel.Severity = pes.Severity
      LEFT JOIN SuperSQL.dbo.LISTBILL_CLIENT n    ON p.Listbill = n.LC_Listbill_Number
--    WHERE DATEDIFF(day, p.ProcessDate, GETDATE()) <= 30
    WHERE p.ProcessDate BETWEEN @dProcessStart AND @dProcessEnd
          AND  pel.ErrDesc NOT LIKE  '%DO NOT INCLUDE'




    SELECT Rows, t.*
    FROM #t t
        JOIN (SELECT  rows = count(*), instanceid FROM #t GROUP BY instanceid) r
            ON t.instanceid = r.instanceid
    ORDER BY  t.Product asc, t.listbill asc, t.instanceid asc, t.Occurrence asc , t.orderby










END --CREATE PROCEDURE [dbo].[PLSP_GetLog]
GO
/****** Object:  StoredProcedure [dbo].[plsp_getHoliday]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_getHoliday]

/*******************************************************************************
* Description : Retrieves the name of a holiday using a date.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      03/14/04    John S      Intial Development
*      07/28/04    MikeT       Fix grant execute error.
*
*******************************************************************************/

@Date varchar(50)

AS
BEGIN
  SET NOCOUNT ON

  SELECT Holiday
  FROM Holidays
  WHERE HolidayDate = @Date

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_WriteToLog]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_WriteToLog]

/***********************************************************************************************************
* Name            : plsp_WriteToLog.SQL
* Description     : Writes information to the ProcessLog table.
*
* Change Log
*      Date        By          Notes
*      ----------  ----------  ---------------------------------------------------------------------------
*      10/17/03    John S      Intial Dev
*      10/23/03    John S      Updated Parameters
*      10/28/03    MikeT       Add grant exec
*      12/08/03    John S      Made ReportID & InstanceID optional
*      06/01/2004  MikeT       Prefix table names with dbo.
*
***********************************************************************************************************/

  @Occurrence datetime,
  @Severity int,
  @Source varchar(250),
  @Message varchar(4000),
  @ReportID int = null,
  @InstanceID int = null

AS
BEGIN
  SET NOCOUNT ON

  INSERT INTO dbo.ProcessLog
    (Type,
     Source,
     Occurrence,
     ReportID,
     InstanceID,
     [Description])
  VALUES
    (@Severity,
     @Source,
     @Occurrence,
     @ReportID,
     @InstanceID,
     @Message)

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetReportID]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetReportID]

/********************************************************************************
* Description : This stored procedure gets report ID for a given product Code
*	            and Acronym
*       Input : RequestID 
*   Creatd on : 2/25/2010  
*       Usage : plsp_GetReportID 'V', 'CV'
********************************************************************************/

@ProductType VARCHAR(5),
@ReportType	 VARCHAR(5)

AS
BEGIN
	SELECT  AR.ID
	  FROM AvailableReports AR
		   jOIN ProductLookup PL ON (PL.ProductID = AR.Product AND AR.Automated = 1 )
	WHERE PL.ProductCode= @ProductType AND AR.Acronym = @ReportType

END
GO
/****** Object:  StoredProcedure [dbo].[plsp_GetRequestsByFilter]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_GetRequestsByFilter]

/*******************************************************************************
* Description : Gets all new and unprocessed requests.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      04/19/2003  John S      Intial Development
*      08/13/2003  MikeT       Revise to be more efficient 
*      08/14/2003  MikeT       Convert to dynamic SQL to prevent having to change 
*                              the stored procedure whenever a new report is added. 
*      09/26/2003  MikeT       Added copious comments to explain what 
*                              the hell I was thinking.
*      10/09/2003  MikeT       grant execute 
*      12/10/2003  MikeT       Add parameter for Where clause and default value.
*      01/26/2003  John S      Added Office to the query
*      06/01/2004  MikeT       Prefix table names with dbo.
*      08/31/2004  John S      Removed OR clause from default filter that
*                              included one-time requests regardless of status.
*      09/27/2004  John S      Added DocTypeCode to the SELECT statement.
*      10/15/2004  MikeT       Rolled back to previous version.
*      05/04/2005  John S      Updated the default filter again.
*
*******************************************************************************/

    @Where varchar(8000) = null,
    @Order varchar(8000) = null


AS
BEGIN
  SET NOCOUNT ON



    DECLARE    @Reports         varchar(8000)
             , @i               int
             , @InsertFields    varchar(8000)
             , @Insert          varchar(2000)
             , @InsertFrom      varchar(2000)
             , @RtnCase         varchar(8000)
             , @RtnSelect       varchar(2000)
             , @RtnFrom         varchar(2000)


    IF(@Where IS NULL)
    BEGIN
        /*****************************************************
        * Get all active the following requests:
        * All active requests except One-Time requests
        * All Back-dated requests that haven't been processed
        * All One-Time requests that haven't been processed
        *****************************************************/
        SELECT @Where = +'WHERE (R.Status = 1 AND R.Frequency <> 7) ' + char(13)                       
                        +' OR (R.Frequency = 7 AND R.Processed IS NULL) ' + char(13)   
                        +' OR (R.Status = 5 AND R.Processed IS NULL) ' + char(13)   
    END

    IF(@Order IS NULL)
    BEGIN
        SELECT @Order = ''
    END



    SELECT @InsertFields = '',   @RtnCase = ''  


    /************************************************************
    Gather all of the possible reports that could be requested 
    into a cursor. We then use the cursor to create the variable 
    list of fields to hold the individual acronyms and the case 
    statement that creates the comma seperated list in the final 
    output.
    ************************************************************/
    DECLARE BldReports CURSOR FOR
        SELECT id FROM AvailableReports

    OPEN BldReports
    FETCH NEXT FROM BldReports INTO @i

    WHILE @@FETCH_STATUS = 0
    BEGIN
--      PRINT '@I = ' + CAST(@I AS CHAR(2))
        SET @InsertFields = @InsertFields + ' ,Rep' + CAST(@i AS char(3)) + ' = CASE rr.ReportID WHEN ' + CAST(@i AS char(3)) + 'THEN ar.Acronym ELSE '+CHAR(39) + CHAR(39) + ' END ' + CHAR(13)
        SET @RtnCase = @RtnCase + 'CASE WHEN LEN(MAX(RTRIM(Rep' +CAST(@i AS char(3))+'))) > 0 THEN MAX(RTRIM(Rep' +CAST(@i AS char(3))+')) + '', '' ELSE '+CHAR(39)+CHAR(39)+' END +' + CHAR(13)

        FETCH NEXT FROM BldReports INTO @i
    END

    CLOSE       BldReports
    DEALLOCATE  BldReports


    /***********************************************************
    Create the strings for the 2 select statements.
        - The first select queries the data with each requested
          report in it's own column.
        - The second select queris the result of the first
          to colapse the n columns down to one with the reports
          as a comma seperated list.
    ***********************************************************/

    SET @Insert = 
                'SELECT    R.[ID] '+ char(13)
               +', R.ListBill '+ char(13)
               +', R.Office ' + char(13)
               +', R.Requestor '+ char(13)
               +', ProductFamily = pf.Description '+ char(13)
               +', Frequency = fq.Description '+ char(13)
               +', FrequencyID = fq.ItemValue '+ char(13)
               +', Timeframe = tf.Description '+ char(13)
               +', TimeframeID = tf.ItemValue '+ char(13)
               +', R.PeriodStart '+ char(13)
               +', R.PeriodEnd '+ char(13)
               +', R.AssumePremiumsPaid '+ char(13)
               +', R.Notes '+ char(13)
               +', [Status] = rs.Description '+ char(13)
               +', R.Processed '+ char(13)

    SET @InsertFrom =            
      +'INTO #Reports '+ char(13)
      +'FROM dbo.Requests R ' + char(13)
      +' JOIN dbo.RequestedReports RR ' + char(13)
      +'  ON R.[ID] = RR.RequestID ' + char(13)
      +' JOIN dbo.AvailableReports AR ' + char(13)
      +'  ON RR.ReportID = AR.[ID] ' + char(13)
      +' JOIN dbo.Upkeep fq ' + char(13)
      +'  ON r.Frequency = fq.ItemValue AND fq.Category = ''Frequency'' ' + char(13)
      +' JOIN dbo.Upkeep tf ' + char(13)
      +'  ON r.TimeFrame = tf.ItemValue   AND tf.Category = ''Timeframe''' + char(13)
      +' JOIN dbo.Upkeep rs ' + char(13)
      +'  ON r.Status = rs.ItemValue      AND rs.Category = ''Request Status'' ' + char(13)
      +' JOIN dbo.Upkeep pf ' + char(13)
      +'  ON ar.Product = pf.ItemValue    AND pf.Category = ''Product Family'' ' + char(13)
        


    SET @RtnSelect =         
        'SELECT ' + char(13)
       +'  [ID] ' + char(13)
       +', ListBill ' + char(13)
       +', Office ' + char(13)
       +', Requestor ' + char(13)
       +', ProductFamily ' + char(13)
       +', Frequency ' + char(13)                   
       +', FrequencyID ' + char(13)                   
       +', Timeframe ' + char(13)                   
       +', TimeframeID ' + char(13)                   
       +', PeriodStart ' + char(13)                  
       +', PeriodEnd ' + char(13)                  
       +', AssumePremiumsPaid ' + char(13)
       +', Notes ' + char(13)
       +', [Status] ' + char(13)
       +', Processed ' + char(13)
       +', Reports = ' + char(13)


    
    SET @RtnFrom  =
       +'FROM #Reports ' + char(13)
       +'GROUP BY [ID] ' + char(13)
       +', ListBill ' + char(13)
       +', Office ' + char(13)
       +', Requestor ' + char(13)
       +', ProductFamily ' + char(13)
       +', Frequency ' + char(13)                   
       +', FrequencyID ' + char(13)                   
       +', Timeframe ' + char(13)                   
       +', TimeframeID ' + char(13)                   
       +', PeriodStart ' + char(13)                  
       +', PeriodEnd ' + char(13)                  
       +', AssumePremiumsPaid ' + char(13)
       +', Notes ' + char(13)
       +', [Status] ' + char(13)
       +', Processed ' + char(13)


    SET @RtnCase = LEFT(@RtnCase, LEN(RTRIM(@RtnCase))-2)


    EXEC ( @insert + @InsertFields + @InsertFrom + @Where + ' ' +  @RtnSelect + @RtnCase + @RtnFrom + ' ' +@Order )

print ( @insert + @InsertFields + @InsertFrom + @Where + ' ' +  @RtnSelect + @RtnCase + @RtnFrom + ' ' +@Order )

    /**********************************************************************************************************
    The following select statements are an example of what executes on the line above. One EXEC statement is 
    used instead of two because when two was used the second select could not access the temp table created in
    the first.

    **********************************************************************************************************/

    /********************************************************************************************************
    SELECT    R.[ID] 
        , R.ListBill , R.Requestor 
        , ProductFamily = pf.Description 
        , Frequency = fq.Description 
        , FrequencyID = fq.ItemValue 
        , Timeframe = tf.Description 
        , TimeframeID = tf.ItemValue 
        , R.PeriodStart 
        , R.PeriodEnd 
        , R.AssumePremiumsPaid 
        , R.Notes 
        , [Status] = rs.Description 
        , R.Processed 
        --Get the acronym for any reports requested for each request into a seperate column
        ,Rep1   = CASE rr.ReportID WHEN 1  THEN ar.Acronym ELSE '' END 
        ,Rep2   = CASE rr.ReportID WHEN 2  THEN ar.Acronym ELSE '' END 
        ,Rep3   = CASE rr.ReportID WHEN 3  THEN ar.Acronym ELSE '' END 
        ,Rep4   = CASE rr.ReportID WHEN 4  THEN ar.Acronym ELSE '' END 
        ,Rep5   = CASE rr.ReportID WHEN 5  THEN ar.Acronym ELSE '' END 
        ,Rep6   = CASE rr.ReportID WHEN 6  THEN ar.Acronym ELSE '' END 
        ,Rep7   = CASE rr.ReportID WHEN 7  THEN ar.Acronym ELSE '' END 
        ,Rep8   = CASE rr.ReportID WHEN 8  THEN ar.Acronym ELSE '' END 
        ,Rep9   = CASE rr.ReportID WHEN 9  THEN ar.Acronym ELSE '' END 
        ,Rep10  = CASE rr.ReportID WHEN 10 THEN ar.Acronym ELSE '' END 
        ,Rep11  = CASE rr.ReportID WHEN 11 THEN ar.Acronym ELSE '' END 
        ,Rep12  = CASE rr.ReportID WHEN 12 THEN ar.Acronym ELSE '' END 
        ,Rep13  = CASE rr.ReportID WHEN 13 THEN ar.Acronym ELSE '' END 
        ,Rep14  = CASE rr.ReportID WHEN 14 THEN ar.Acronym ELSE '' END 
        ,Rep15  = CASE rr.ReportID WHEN 15 THEN ar.Acronym ELSE '' END 
        ,Rep16  = CASE rr.ReportID WHEN 16 THEN ar.Acronym ELSE '' END 
        ,Rep17  = CASE rr.ReportID WHEN 17 THEN ar.Acronym ELSE '' END 
        ,Rep18  = CASE rr.ReportID WHEN 18 THEN ar.Acronym ELSE '' END 
        ,Rep19  = CASE rr.ReportID WHEN 19 THEN ar.Acronym ELSE '' END 
        ,Rep20  = CASE rr.ReportID WHEN 20 THEN ar.Acronym ELSE '' END 
        ,Rep21  = CASE rr.ReportID WHEN 21 THEN ar.Acronym ELSE '' END 
        ,Rep22  = CASE rr.ReportID WHEN 22 THEN ar.Acronym ELSE '' END 
        ,Rep23  = CASE rr.ReportID WHEN 23 THEN ar.Acronym ELSE '' END 
        ,Rep24  = CASE rr.ReportID WHEN 24 THEN ar.Acronym ELSE '' END 
        ,Rep25  = CASE rr.ReportID WHEN 25 THEN ar.Acronym ELSE '' END 
        ,Rep26  = CASE rr.ReportID WHEN 26 THEN ar.Acronym ELSE '' END 
        ,Rep27  = CASE rr.ReportID WHEN 27 THEN ar.Acronym ELSE '' END 
        ,Rep28  = CASE rr.ReportID WHEN 28 THEN ar.Acronym ELSE '' END 
        ,Rep29  = CASE rr.ReportID WHEN 29 THEN ar.Acronym ELSE '' END 
        ,Rep30  = CASE rr.ReportID WHEN 30 THEN ar.Acronym ELSE '' END 
        ,Rep31  = CASE rr.ReportID WHEN 31 THEN ar.Acronym ELSE '' END 
    INTO #Reports   --Inserts into a temp table
    FROM Requests R 
     JOIN RequestedReports RR   ON R.[ID] = RR.RequestID 
     JOIN AvailableReports AR   ON RR.ReportID = AR.[ID] 
     JOIN Upkeep fq             ON r.Frequency = fq.ItemValue AND fq.Category = 'Frequency' 
     JOIN Upkeep tf             ON r.TimeFrame = tf.ItemValue   AND tf.Category = 'Timeframe'
     JOIN Upkeep rs             ON r.Status = rs.ItemValue      AND rs.Category = 'Request Status' 
     JOIN Upkeep pf             ON ar.Product = pf.ItemValue    AND pf.Category = 'Product Family' 
    WHERE (R.Status = 1) 
     OR (R.Status = 5       And Processed IS NULL) 
     OR (R.Frequency = 7    And Processed IS NULL) 


    SELECT 
          [ID] 
        , ListBill 
        , Requestor 
        , ProductFamily 
        , Frequency 
        , FrequencyID 
        , Timeframe 
        , TimeframeID 
        , PeriodStart 
        , PeriodEnd 
        , AssumePremiumsPaid 
        , Notes 
        , [Status] 
        , Processed 
        -- This colapses the n (31 in this example) columns into one with the acronyms as a comma seperated list
        , Reports = 
            CASE WHEN LEN(MAX(RTRIM(Rep1  ))) > 0 THEN MAX(RTRIM(Rep1  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep2  ))) > 0 THEN MAX(RTRIM(Rep2  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep3  ))) > 0 THEN MAX(RTRIM(Rep3  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep4  ))) > 0 THEN MAX(RTRIM(Rep4  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep5  ))) > 0 THEN MAX(RTRIM(Rep5  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep6  ))) > 0 THEN MAX(RTRIM(Rep6  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep7  ))) > 0 THEN MAX(RTRIM(Rep7  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep8  ))) > 0 THEN MAX(RTRIM(Rep8  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep9  ))) > 0 THEN MAX(RTRIM(Rep9  )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep10 ))) > 0 THEN MAX(RTRIM(Rep10 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep11 ))) > 0 THEN MAX(RTRIM(Rep11 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep12 ))) > 0 THEN MAX(RTRIM(Rep12 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep13 ))) > 0 THEN MAX(RTRIM(Rep13 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep14 ))) > 0 THEN MAX(RTRIM(Rep14 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep15 ))) > 0 THEN MAX(RTRIM(Rep15 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep16 ))) > 0 THEN MAX(RTRIM(Rep16 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep17 ))) > 0 THEN MAX(RTRIM(Rep17 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep18 ))) > 0 THEN MAX(RTRIM(Rep18 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep19 ))) > 0 THEN MAX(RTRIM(Rep19 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep20 ))) > 0 THEN MAX(RTRIM(Rep20 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep21 ))) > 0 THEN MAX(RTRIM(Rep21 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep22 ))) > 0 THEN MAX(RTRIM(Rep22 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep23 ))) > 0 THEN MAX(RTRIM(Rep23 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep24 ))) > 0 THEN MAX(RTRIM(Rep24 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep25 ))) > 0 THEN MAX(RTRIM(Rep25 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep26 ))) > 0 THEN MAX(RTRIM(Rep26 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep27 ))) > 0 THEN MAX(RTRIM(Rep27 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep28 ))) > 0 THEN MAX(RTRIM(Rep28 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep29 ))) > 0 THEN MAX(RTRIM(Rep29 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep30 ))) > 0 THEN MAX(RTRIM(Rep30 )) + ', ' ELSE '' END +
            CASE WHEN LEN(MAX(RTRIM(Rep31 ))) > 0 THEN MAX(RTRIM(Rep31 )) + ', ' ELSE '' END 
    FROM #Reports 
    GROUP BY [ID] 
        , ListBill 
        , Requestor 
        , ProductFamily 
        , Frequency 
        , FrequencyID 
        , Timeframe 
        , TimeframeID 
        , PeriodStart 
        , PeriodEnd 
        , AssumePremiumsPaid 
        , Notes 
        , [Status] 
        , Processed 

    ********************************************************************************************************/


END     --CREATE PROCEDURE [dbo].[plsp_GetRequestsByFilter]
GO
/****** Object:  StoredProcedure [dbo].[plsp_RptGen_Tester]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[plsp_RptGen_Tester]

/*******************************************************************************
* File        : plsp_RptGen_Tester.sql
* Description : Gets all request that could have reports Generated.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      08/25/2003  MikeT       Intial Dev
*      06/01/2004  MikeT       Prefix table names with dbo.
*      09/16/2004  MikeT       Join to MCReport.dbo.ProcessLog to filter out 
*                              instance with no data.
*
*******************************************************************************/

AS
BEGIN
  SET NOCOUNT ON



    DECLARE    @Reports         varchar(8000)
             , @i               int
             , @InsertFields    varchar(8000)
             , @Insert          varchar(2000)
             , @InsertFrom      varchar(2000)
             , @RtnCase         varchar(8000)
             , @RtnSelect       varchar(2000)
             , @RtnFrom         varchar(2000)





    SELECT @InsertFields = '',   @RtnCase = ''  


    DECLARE BldReports CURSOR FOR
        SELECT id FROM dbo.AvailableReports

    OPEN BldReports
    FETCH NEXT FROM BldReports INTO @i

    WHILE @@FETCH_STATUS = 0
    BEGIN
--      PRINT '@I = ' + CAST(@I AS CHAR(2))
        SET @InsertFields = @InsertFields + ' ,Rep' + CAST(@i AS char(3)) + ' = CASE rr.ReportID WHEN ' + CAST(@i AS char(3)) + 'THEN ar.Acronym ELSE '+CHAR(39) + CHAR(39) + ' END ' + CHAR(13)
        SET @RtnCase = @RtnCase + 'CASE WHEN LEN(MAX(RTRIM(Rep' +CAST(@i AS char(3))+'))) > 0 THEN MAX(RTRIM(Rep' +CAST(@i AS char(3))+')) + '', '' ELSE '+CHAR(39)+CHAR(39)+' END +' + CHAR(13)

        FETCH NEXT FROM BldReports INTO @i
    END

    CLOSE       BldReports
    DEALLOCATE  BldReports




    SET @Insert = 
                'SELECT  i.InstanceID,  R.[ID] '+ char(13)
               +', R.ListBill '+ char(13)
               +', ProductFamily = pf.Description '+ char(13)
               +', R.PeriodStart '+ char(13)
               +', R.PeriodEnd '+ char(13)
               +', R.AssumePremiumsPaid '+ char(13)

    SET @InsertFrom =            
      +'INTO #Reports '+ char(13)
      +'FROM dbo.Requests R ' + char(13)
      +' JOIN dbo.RequestedReports RR ON R.[ID] = RR.RequestID ' + char(13)
      +' JOIN dbo.AvailableReports AR ON RR.ReportID = AR.[ID] ' + char(13)
      +' JOIN dbo.Upkeep pf ON ar.Product = pf.ItemValue    AND pf.Category = ''Product Family'' ' + char(13)
      +' JOIN dbo.RequestInstance i ON r.id = i.RequestID ' + char(13)
      +' JOIN MCReport.dbo.ProcessLog l ON i.InstanceID = l.InstanceID AND l.Success in (1, 3) ' + char(13)
      +' JOIN SuperSQL.dbo.LISTBILL_CLIENT lc on  lc.LC_Listbill_Number = r.listbill ' + char(13)
      +'WHERE ar.Product in (1, 2) ' + char(13)
      +'ORDER BY i.InstanceID '

        


    SET @RtnSelect =         
        'SELECT ' + char(13)
       +'  Selected = CONVERT(bit, 0) ' + char(13)
       +', InstanceID ' + char(13)
       +', [ID] ' + char(13)
       +', ListBill ' + char(13)
       +', PeriodStart ' + char(13)                  
       +', PeriodEnd ' + char(13)  
       +', ProductFamily ' + char(13)
       +', AssumePremiumsPaid ' + char(13)
       +', Reports =' + char(13)


    
    SET @RtnFrom  =
       +'FROM #Reports ' + char(13)
       +'GROUP BY [ID] ' + char(13)
       +', InstanceID ' + char(13)
       +', ListBill ' + char(13)
       +', ProductFamily ' + char(13)
       +', PeriodStart ' + char(13)                  
       +', PeriodEnd ' + char(13)                  
       +', AssumePremiumsPaid ' + char(13)


    SET @RtnCase = LEFT(@RtnCase, LEN(RTRIM(@RtnCase))-2)

--  print ( @insert + @InsertFields + @InsertFrom +' '+  @RtnSelect + @RtnCase + @RtnFrom )

    EXEC ( @insert + @InsertFields + @InsertFrom +' '+  @RtnSelect + @RtnCase + @RtnFrom )


END
GO
/****** Object:  StoredProcedure [dbo].[PLSP_GetSchedule]    Script Date: 06/01/2011 15:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLSP_GetSchedule]

/*******************************************************************************
* Description : Gets all the requests for a given listbill, request ID, or
*               office and returns the recordset in "Schedule" format.
* 
* Change Log
*
*      Date        By          Notes
*      ----------  ----------  ------------------------------------------------
*      02/13/2003  John S      Intial Development
*      04/15/2003  Mike T      Revision to get reports in comma
*                                            delimited list.
*      08/14/2003  MikeT       Revised to improve performance.
*      09/30/2003  MikeT       Added copious comments to explain what 
*                              the hell I was thinking.
*      10/09/2003  MikeT       grant execute 
*      11/14/2003  MikeT       add Requestor to output
*      03/03/2004  MikeT       Change iStatus from int to Varchar 
*      06/01/2004  MikeT       Prefix table names with dbo.
*
*
*******************************************************************************/

@cListBill      varchar(10) = null,
@iRequestID     int         = null,
@bExpired       int         = null,
@iStatus        varchar(50) --int

AS
BEGIN
    SET NOCOUNT ON

    DECLARE    @Reports         varchar(8000)
             , @i               int
             , @max             int
             , @cFilter         varchar(100)
             , @InsertFields    varchar(8000)
             , @Insert          varchar(2000)
             , @InsertFrom      varchar(2000)
             , @RtnCase         varchar(8000)
             , @RtnSelect       varchar(2000)
             , @RtnFrom         varchar(2000)


              
    SET @cFilter = ''

    IF (@bExpired IS NOT NULL)
      SET @cFilter = 'WHERE R.Status IN (3, ' + CONVERT(varchar, @iStatus) + ')' + CHAR(13)
    ELSE
      SET @cFilter = 'WHERE R.Status IN ( ' + CONVERT(varchar, @iStatus) + ')' + CHAR(13)

    IF (@cListBill IS NOT NULL)
      SET @cFilter = @cFilter + '  AND R.ListBill = ''' + @cListBill + '''' + CHAR(13)
    ELSE IF (@iRequestID IS NOT NULL)
      SET @cFilter = @cFilter + '  AND R.[ID] = ' + CONVERT(varchar, @iRequestID) + CHAR(13)
    
    
    SELECT @InsertFields = '',   @RtnCase = ''  


    /************************************************************
    Gather all of the possible reports that could be requested 
    into a cursor. We then use the cursor to create the variable 
    list of fields to hold the individual acronyms and the case 
    statement that creates the comma seperated list in the final 
    output.
    ************************************************************/

    
    
    DECLARE BldReports CURSOR FOR
        SELECT id FROM dbo.AvailableReports

    OPEN BldReports
    FETCH NEXT FROM BldReports INTO @i

    WHILE @@FETCH_STATUS = 0
    BEGIN
--      PRINT '@I = ' + CAST(@I AS CHAR(2))
        SET @InsertFields = @InsertFields + ' ,Rep' + CAST(@i AS char(3)) + ' = CASE rr.ReportID WHEN ' + CAST(@i AS char(3)) + 'THEN ar.Acronym ELSE '+CHAR(39) + CHAR(39) + ' END ' + CHAR(13)
        SET @RtnCase = @RtnCase + 'CASE WHEN LEN(MAX(RTRIM(Rep' +CAST(@i AS char(3))+'))) > 0 THEN MAX(RTRIM(Rep' +CAST(@i AS char(3))+')) + '', '' ELSE '+CHAR(39)+CHAR(39)+' END +' + CHAR(13)

        FETCH NEXT FROM BldReports INTO @i
    END

    CLOSE       BldReports
    DEALLOCATE  BldReports


    /***********************************************************
    Create the strings for the 2 select statements.
        - The first select queries the data with each requested
          report in it's own column.
        - The second select queris the result of the first
          to colapse the n columns down to one with the reports
          as a comma seperated list.
    ***********************************************************/


    SET @Insert = 
       + ' SELECT R.[ID] ' + char(13)
       + ' , R.Office ' + char(13)
       + ' , R.ListBill ' + char(13)

       + ' , Frequency = fq.Description ' + char(13)
       + ' , FrequencyID = fq.ItemValue ' + char(13)
       + ' , Timeframe = tf.Description ' + char(13)
       + ' , TimeframeID = tf.ItemValue ' + char(13)
       + ' , R.PeriodStart ' + char(13)
       + ' , R.PeriodEnd ' + char(13)
       + ' , R.AssumePremiumsPaid ' + char(13)
       + ' , R.Notes ' + char(13)
       + ' , R.Processed ' + char(13)
       + ' , R.Requestor ' + char(13)
       + ' , R.Status ' + char(13)

    SET @InsertFrom = 
       + ' INTO #Reports ' + char(13)
       + ' FROM dbo.Requests R' + char(13)  
       + '  JOIN dbo.RequestedReports RR' + char(13) 
       + '   ON R.[ID] = RR.RequestID' + char(13) 
       + '  JOIN dbo.AvailableReports AR' + char(13) 
       + '   ON RR.ReportID = AR.[ID]' + char(13) 
       + '  JOIN dbo.Upkeep fq' + char(13) 
       + '   ON r.Frequency = fq.ItemValue   AND fq.Category = ''Frequency'' ' + char(13) 
       + '  JOIN dbo.Upkeep tf' + char(13) 
       + '   ON r.TimeFrame = tf.ItemValue   AND tf.Category = ''Timeframe'' ' + char(13) 


    SET @RtnSelect  =
         'SELECT [ID] ' + char(13)
       + ' , Office ' + char(13)
       + ' , ListBill ' + char(13)
       + ' , Frequency ' + char(13)
       + ' , FrequencyID ' + char(13)
       + ' , Timeframe ' + char(13)
       + ' , TimeframeID ' + char(13)
       + ' , PeriodStart ' + char(13)
       + ' , PeriodEnd ' + char(13)
       + ' , AssumePremiumsPaid ' + char(13)
       + ' , Notes ' + char(13)
       + ' , Processed ' + char(13)
       + ' , Requestor ' + char(13)
       + ' , Status '    + char(13)
       + ' , Reports = '



    SET @RtnFrom = 
          'FROM #Reports ' +CHAR(13) 
        + 'GROUP BY ID, Office, ListBill, Frequency, FrequencyID, Timeframe, TimeframeID, PeriodStart, PeriodEnd, AssumePremiumsPaid, Notes, Processed, Requestor, Status '


    SET @RtnCase = LEFT(@RtnCase, LEN(RTRIM(@RtnCase))-2)


    EXEC ( @insert + @InsertFields + @InsertFrom + @cFilter +' '+  @RtnSelect + @RtnCase + @RtnFrom )



    /**********************************************************************************************************
    The following select statements are an example of what executes on the line above. One EXEC statement is 
    used instead of two because when two was used the second select could not access the temp table created in
    the first.

    **********************************************************************************************************/


    /********************************************************************************************************

     
     SELECT R.[ID] 
          , R.Office 
          , R.ListBill 
          , Frequency = fq.Description 
          , FrequencyID = fq.ItemValue 
          , Timeframe = tf.Description 
          , TimeframeID = tf.ItemValue 
          , R.PeriodStart 
          , R.PeriodEnd 
          , R.AssumePremiumsPaid 
          , R.Notes 
          , R.Processed 
          , R.Requestor 
          ,Rep1   = CASE rr.ReportID WHEN 1  THEN ar.Acronym ELSE '' END 
          ,Rep2   = CASE rr.ReportID WHEN 2  THEN ar.Acronym ELSE '' END 
          ,Rep3   = CASE rr.ReportID WHEN 3  THEN ar.Acronym ELSE '' END 
          ,Rep4   = CASE rr.ReportID WHEN 4  THEN ar.Acronym ELSE '' END 
          ,Rep5   = CASE rr.ReportID WHEN 5  THEN ar.Acronym ELSE '' END  
          ,Rep6   = CASE rr.ReportID WHEN 6  THEN ar.Acronym ELSE '' END 
          ,Rep7   = CASE rr.ReportID WHEN 7  THEN ar.Acronym ELSE '' END 
          ,Rep8   = CASE rr.ReportID WHEN 8  THEN ar.Acronym ELSE '' END 
          ,Rep9   = CASE rr.ReportID WHEN 9  THEN ar.Acronym ELSE '' END 
          ,Rep10  = CASE rr.ReportID WHEN 10 THEN ar.Acronym ELSE '' END 
          ,Rep11  = CASE rr.ReportID WHEN 11 THEN ar.Acronym ELSE '' END 
          ,Rep12  = CASE rr.ReportID WHEN 12 THEN ar.Acronym ELSE '' END 
          ,Rep13  = CASE rr.ReportID WHEN 13 THEN ar.Acronym ELSE '' END 
          ,Rep14  = CASE rr.ReportID WHEN 14 THEN ar.Acronym ELSE '' END 
          ,Rep15  = CASE rr.ReportID WHEN 15 THEN ar.Acronym ELSE '' END 
          ,Rep16  = CASE rr.ReportID WHEN 16 THEN ar.Acronym ELSE '' END 
          ,Rep17  = CASE rr.ReportID WHEN 17 THEN ar.Acronym ELSE '' END 
          ,Rep18  = CASE rr.ReportID WHEN 18 THEN ar.Acronym ELSE '' END 
          ,Rep19  = CASE rr.ReportID WHEN 19 THEN ar.Acronym ELSE '' END 
          ,Rep20  = CASE rr.ReportID WHEN 20 THEN ar.Acronym ELSE '' END 
          ,Rep21  = CASE rr.ReportID WHEN 21 THEN ar.Acronym ELSE '' END 
          ,Rep22  = CASE rr.ReportID WHEN 22 THEN ar.Acronym ELSE '' END 
          ,Rep23  = CASE rr.ReportID WHEN 23 THEN ar.Acronym ELSE '' END 
          ,Rep24  = CASE rr.ReportID WHEN 24 THEN ar.Acronym ELSE '' END 
          ,Rep25  = CASE rr.ReportID WHEN 25 THEN ar.Acronym ELSE '' END 
          ,Rep26  = CASE rr.ReportID WHEN 26 THEN ar.Acronym ELSE '' END 
          ,Rep27  = CASE rr.ReportID WHEN 27 THEN ar.Acronym ELSE '' END 
          ,Rep28  = CASE rr.ReportID WHEN 28 THEN ar.Acronym ELSE '' END 
          ,Rep29  = CASE rr.ReportID WHEN 29 THEN ar.Acronym ELSE '' END 
          ,Rep30  = CASE rr.ReportID WHEN 30 THEN ar.Acronym ELSE '' END 
          ,Rep31  = CASE rr.ReportID WHEN 31 THEN ar.Acronym ELSE '' END 
      INTO #Reports 
      FROM Requests R
       JOIN RequestedReports RR     ON R.[ID] = RR.RequestID
       JOIN AvailableReports AR     ON RR.ReportID = AR.[ID]
       JOIN Upkeep fq               ON r.Frequency = fq.ItemValue   AND fq.Category = 'Frequency' 
       JOIN Upkeep tf               ON r.TimeFrame = tf.ItemValue   AND tf.Category = 'Timeframe' 
     WHERE R.Status = 1
       AND R.ListBill = 'a681110000'



     SELECT [ID] 
          , Office 
          , ListBill 
          , Frequency 
          , FrequencyID 
          , Timeframe 
          , TimeframeID 
          , PeriodStart 
          , PeriodEnd 
          , AssumePremiumsPaid 
          , Notes 
          , Processed 
          , Requestor 
          , Reports = 
                 CASE WHEN LEN(MAX(RTRIM(Rep1  ))) > 0 THEN MAX(RTRIM(Rep1  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep2  ))) > 0 THEN MAX(RTRIM(Rep2  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep3  ))) > 0 THEN MAX(RTRIM(Rep3  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep4  ))) > 0 THEN MAX(RTRIM(Rep4  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep5  ))) > 0 THEN MAX(RTRIM(Rep5  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep6  ))) > 0 THEN MAX(RTRIM(Rep6  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep7  ))) > 0 THEN MAX(RTRIM(Rep7  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep8  ))) > 0 THEN MAX(RTRIM(Rep8  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep9  ))) > 0 THEN MAX(RTRIM(Rep9  )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep10 ))) > 0 THEN MAX(RTRIM(Rep10 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep11 ))) > 0 THEN MAX(RTRIM(Rep11 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep12 ))) > 0 THEN MAX(RTRIM(Rep12 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep13 ))) > 0 THEN MAX(RTRIM(Rep13 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep14 ))) > 0 THEN MAX(RTRIM(Rep14 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep15 ))) > 0 THEN MAX(RTRIM(Rep15 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep16 ))) > 0 THEN MAX(RTRIM(Rep16 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep17 ))) > 0 THEN MAX(RTRIM(Rep17 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep18 ))) > 0 THEN MAX(RTRIM(Rep18 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep19 ))) > 0 THEN MAX(RTRIM(Rep19 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep20 ))) > 0 THEN MAX(RTRIM(Rep20 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep21 ))) > 0 THEN MAX(RTRIM(Rep21 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep22 ))) > 0 THEN MAX(RTRIM(Rep22 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep23 ))) > 0 THEN MAX(RTRIM(Rep23 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep24 ))) > 0 THEN MAX(RTRIM(Rep24 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep25 ))) > 0 THEN MAX(RTRIM(Rep25 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep26 ))) > 0 THEN MAX(RTRIM(Rep26 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep27 ))) > 0 THEN MAX(RTRIM(Rep27 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep28 ))) > 0 THEN MAX(RTRIM(Rep28 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep29 ))) > 0 THEN MAX(RTRIM(Rep29 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep30 ))) > 0 THEN MAX(RTRIM(Rep30 )) + ', ' ELSE '' END +
                 CASE WHEN LEN(MAX(RTRIM(Rep31 ))) > 0 THEN MAX(RTRIM(Rep31 )) + ', ' ELSE '' END 
     FROM #Reports 
     GROUP BY   ID, 
                Office, 
                ListBill, 
                Frequency, 
                FrequencyID, 
                Timeframe, 
                TimeframeID, 
                PeriodStart, 
                PeriodEnd, 
                AssumePremiumsPaid, 
                Notes, 
                Processed 

    ********************************************************************************************************/


/*
     PRINT ISNULL(@INSERT, '@INSERT')
     PRINT ISNULL(@InsertFields, '@InsertFields')
     PRINT ISNULL(@InsertFrom, '@InsertFrom')
     PRINT ISNULL(@cFilter, '@cFilter)')

     PRINT ISNULL(@RtnSelect, '@RtnSelect)')
     PRINT ISNULL(@RtnCase, '@RtnCase)')
     PRINT ISNULL(@RtnFrom, '@RtnFrom)')
*/

  

END --CREATE PROCEDURE [dbo].[PLSP_GetSchedule]
GO
