
USE SIProcessing_Attribution

IF OBJECT_ID('tempdb..#ClientsToSkip') IS NOT NULL 
    DROP TABLE #ClientsToSkip

IF OBJECT_ID('tempdb..#Webservers') IS NOT NULL 
    DROP TABLE #Webservers
      
      
      
DECLARE @StartDate DATETIME ,
    @EndDate DATETIME ,
    @StartDateLastWeek DATETIME ,
    @EndDateLastWeek DATETIME ,
    @CompareDay INT ,
    @Report BIT = 1
    
CREATE TABLE #ClientsToSkip ( ClientID INT )  
--CREATE TABLE #Webservers ( WebserverID INT )  

--INSERT  INTO #Webservers
--        ( WebserverID )
--VALUES  ( 4 )



SET @StartDate = '2012-09-02 00:00'
SET @EndDate = '2012-09-04 00:00' 
SET @CompareDay = 1

INSERT  INTO #ClientsToSkip
        ( ClientID )
VALUES  ( 4711 ),
        ( 4712 ),
        ( 4715 ),
        ( 4713 ),
        ( 4714 ),
        ( 3233 ),
        ( 3486 ),
        ( 4588 ),
        ( 4756 ),
        ( 4948 ),
        ( 4589 ),
        ( 4576 ),
        ( 4941 ),
        ( 4579 ),
        ( 4577 ),
        ( 4570 ),
        ( 3230 )

SET @StartDateLastWeek = DATEADD(day, -@CompareDay, @StartDate)
SET @EndDateLastWeek = DATEADD(day, -@CompareDay, @EndDate) ;

IF @Report = 0 
    BEGIN

        IF OBJECT_ID('tempdb..#TA') IS NOT NULL 
            DROP TABLE #TA

        CREATE TABLE #TA
            (
              WebServerID INT ,
              TIME VARCHAR(5) ,
              Actions INT
            )

        IF OBJECT_ID('tempdb..#TAOld') IS NOT NULL 
            DROP TABLE #TAOld

        CREATE TABLE #TAOld
            (
              WebServerID INT ,
              TIME VARCHAR(5) ,
              ActionsCompare INT
            )

        IF OBJECT_ID('tempdb..#TC') IS NOT NULL 
            DROP TABLE #TC

        CREATE TABLE #TC
            (
              WebServerID INT ,
              TIME VARCHAR(5) ,
              MatchedActions INT
            )

        IF OBJECT_ID('tempdb..#TCOld') IS NOT NULL 
            DROP TABLE #TCOLD

        CREATE TABLE #TCOld
            (
              WebServerID INT ,
              TIME VARCHAR(5) ,
              MatchedActionsCompare INT
            )

        IF OBJECT_ID('tempdb..#TE') IS NOT NULL 
            DROP TABLE #TE

        CREATE TABLE #TE
            (
              TIME VARCHAR(5) ,
              Exposures INT
            )

        IF OBJECT_ID('tempdb..#TEOld') IS NOT NULL 
            DROP TABLE #TEOLD

        CREATE TABLE #TEOld
            (
              TIME VARCHAR(5) ,
              ExposuresCompare INT
            )

    END

--TA

IF @Report = 0 
    BEGIN
    
        INSERT  INTO #TA
                ( WebServerID ,
                  TIME ,
                  Actions 
                )
                SELECT  WebServerID ,
                        CONVERT(VARCHAR(5), CreatedateUTC, ( 8 )) AS Time ,
                        COUNT(1) AS Actions
                FROM    TrackedAction
                WHERE   CreatedateUTC >= @StartDate
                        AND CreatedateUTC < @EndDate
                        AND clientid NOT IN ( SELECT    ClientID
                                              FROM      #ClientsToSkip )
                        AND TrackedActionID > 0
                GROUP BY WebServerID ,
                        CONVERT(VARCHAR(5), CreatedateUTC, ( 8 ))
      
      
        CREATE CLUSTERED INDEX IDX_TA_Temp_Time ON #TA(Time) 
      
        CREATE NONCLUSTERED INDEX IDX_TA_Temp_WebserverID ON #TA(WebServerID)
      
        --DELETE  #TA
        --WHERE   ISNULL(WebServerID,0) NOT IN ( SELECT WebServerID
        --                             FROM   #Webservers )
                                     
        RAISERROR('TA',0,1) WITH NOWAIT
      
    END

--TA OLD

IF @Report = 0 
    BEGIN
    
        INSERT  INTO #TAOld
                ( WebServerID ,
                  TIME ,
                  ActionsCompare 
                )
                SELECT  WebserverID ,
                        CONVERT(VARCHAR(5), CreatedateUTC, ( 8 )) AS Time ,
                        COUNT(1) AS ActionsCompare
                FROM    TrackedAction
                WHERE   CreatedateUTC >= @StartDateLastWeek
                        AND CreatedateUTC < @EndDateLastWeek
                        AND clientid NOT IN ( SELECT    ClientID
                                              FROM      #ClientsToSkip )
                        AND TrackedActionID > 0
                GROUP BY WebServerID ,
                        CONVERT(VARCHAR(5), CreatedateUTC, ( 8 ))
   
        CREATE CLUSTERED INDEX IDX_TAOld_Temp_Time ON #TAOld(Time) 
      
        CREATE NONCLUSTERED INDEX IDX_TAOld_Temp_WebserverID ON #TAOld(WebServerID)  
      
      
        --DELETE  #TAOld
        --WHERE   ISNULL(WebServerID,0) NOT IN ( SELECT WebServerID
        --                             FROM   #Webservers )
                                     
                                     
        RAISERROR('TAOld',0,1) WITH NOWAIT
    END

--TC
IF @Report = 0 
    BEGIN
    
        INSERT  INTO #TC
                ( WebServerID ,
                  TIME ,
                  MatchedActions 
                )
                SELECT  WebserverID ,
                        CONVERT(VARCHAR(5), Createddate, ( 8 )) AS Time ,
                        COUNT(1) AS MatchedActions
                FROM    SIProcessing_CacheHistory.dbo.TrackedCache
                WHERE   Createddate >= @StartDate
                        AND Createddate < @EndDate
                        AND clientid NOT IN ( SELECT    ClientID
                                              FROM      #ClientsToSkip )
                        AND TrackedActionID > 0
                GROUP BY WebserverID ,
                        CONVERT(VARCHAR(5), Createddate, ( 8 ))

        CREATE CLUSTERED INDEX IDX_TC_Temp_Time ON #TC(Time)
  
        CREATE NONCLUSTERED INDEX IDX_TC_Temp_WebserverID ON #TC(WebServerID) 
      
        --DELETE  #TC
        --WHERE   ISNULL(WebServerID,0) NOT IN ( SELECT WebServerID
        --                             FROM   #Webservers ) 
                                     
          
        RAISERROR('TC',0,1) WITH NOWAIT                                
    END   
      
-- Old TC      
IF @Report = 0 
    BEGIN
    
        INSERT  INTO #TCOld
                ( WebServerID ,
                  TIME ,
                  MatchedActionsCompare 
                )
                SELECT  WEBSERVERID ,
                        CONVERT(VARCHAR(5), Createddate, ( 8 )) AS Time ,
                        COUNT(1) AS MatchedActionsCompare
                FROM    SIProcessing_CacheHistory.dbo.TrackedCache
                WHERE   Createddate >= @StartDateLastWeek
                        AND Createddate < @EndDateLastWeek
                        AND clientid NOT IN ( SELECT    ClientID
                                              FROM      #ClientsToSkip )
                        AND TrackedActionID > 0
                GROUP BY WebserverID ,
                        CONVERT(VARCHAR(5), Createddate, ( 8 ))

        CREATE CLUSTERED INDEX IDX_TCOLD_Temp_Time ON #TCOLD(Time)
  
        CREATE NONCLUSTERED INDEX IDX_TCOLD_Temp_WebserverID ON #TCOLD(WebServerID) 
      
        --DELETE  #TCOLD
        --WHERE   ISNULL(WebServerID,0) NOT IN ( SELECT WebServerID
        --                             FROM   #Webservers )  
                                     
        RAISERROR('TCOld',0,1) WITH NOWAIT    
    END

IF @Report = 0 
    BEGIN
    
        INSERT  INTO #TEOld
                ( WebserverID ,
                  TIME ,
                  ExposuresCompare
                )
                SELECT  te.WebServerID ,
                        CONVERT(VARCHAR(5), tem.createdateutc, ( 8 )) AS Time ,
                        COUNT(1) AS ExposuresCompare
                FROM    TrackedExposureMaster tem
                JOIN dbo.TrackedExposure te ON tem.TrackedExposureID = te.TrackedExposureID
					AND tem.ClientID = te.ClientID 
                WHERE   tem.createdateutc >= @StartDateLastWeek
                        AND tem.createdateutc < @EndDateLastWeek
                        AND tem.ExposureTypeID < 4
                        AND tem.clientid NOT IN ( SELECT    ClientID
                                              FROM      #ClientsToSkip )                  
                GROUP BY te.WebServerID ,
                        CONVERT(VARCHAR(5), tem.createdateutc, ( 8 ))
           
        CREATE CLUSTERED INDEX IDX_TEOld_Temp_Time ON #TEOld(Time) 
        
        CREATE NONCLUSTERED INDEX IDX_TEOLD_Temp_WebserverID ON #TEOLD(WebServerID) 
      
        --DELETE  #TeOLD
        --WHERE   WebServerID NOT IN ( SELECT WebServerID
        --                             FROM   #Webservers )  
                                     
        RAISERROR('TEOld',0,1) WITH NOWAIT
       
       
    END


IF @Report = 0 
    BEGIN
    
        INSERT  INTO #TEOld
                ( TIME ,
                  ExposuresCompare 
                )
                SELECT  CONVERT(VARCHAR(5), [createdateutc], ( 8 )) AS Time ,
                        COUNT(1) AS ExposuresCompare
                FROM    TrackedExposureMaster
                WHERE   createdateutc >= @StartDateLastWeek
                        AND createdateutc < @EndDateLastWeek
                        AND [ExposureTypeID] < 4
                        AND clientid NOT IN ( SELECT    ClientID
                                              FROM      #ClientsToSkip )
                GROUP BY CONVERT(VARCHAR(5), [createdateutc], ( 8 ))
           
        CREATE CLUSTERED INDEX IDX_TEOld_Temp_Time ON #TEOld(Time) 
        
        
        RAISERROR('TEOld',0,1) WITH NOWAIT
       
       
    END
 
IF @Report = 0 
    BEGIN
    
        INSERT  INTO #TE
                ( TIME ,
                  Exposures 
                )
                SELECT  CONVERT(VARCHAR(5), [createdateutc], ( 8 )) AS Time ,
                        COUNT(1) AS Exposures
                FROM    TrackedExposureMaster
                WHERE   createdateutc >= @StartDate
                        AND createdateutc < @EndDate
                        AND [ExposureTypeID] < 4
                        AND clientid NOT IN ( SELECT    ClientID
                                              FROM      #ClientsToSkip )
                GROUP BY CONVERT(VARCHAR(5), [createdateutc], ( 8 ))
           
           
           
        CREATE CLUSTERED INDEX IDX_TE_Temp_Time ON #TE(Time)
        
        
        RAISERROR('TE',0,1) WITH NOWAIT
       
       
    END
           
SELECT  tlw.Time ,
        tlw.ActionsCompare ,
        ISNULL(Actions, 0) AS Actions ,
        ExposuresCompare ,
        ISNULL(Exposures, 0) AS Exposures ,
        ISNULL(MatchedActionsCompare, 0) ,
        ISNULL(MatchedActions, 0) AS MatchedActions
FROM    #TAOld tlw
        LEFT JOIN #TA t ON tlw.TIME = t.TIME
        LEFT JOIN #TE e ON tlw.TIME = e.TIME
        LEFT JOIN #TEOLD elw ON tlw.TIME = elw.TIME
        LEFT JOIN #TC mt ON tlw.Time = mt.Time
        LEFT JOIN #TCOLD mtlw ON tlw.Time = mtlw.Time
ORDER BY tlw.Time



