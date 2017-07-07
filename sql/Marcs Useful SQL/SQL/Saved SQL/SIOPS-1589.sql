USE [SearchIgnite]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SIAdmin].[SI_SP_DFA_Data_Regrab]
@ClientID	INT,
@RecordDateTime DATETIME,
@Comment    VARCHAR(100)
AS
BEGIN
-----------------------------------------------------------------------------------------
--Change History
-----------------------------------------------------------------------------------------
--09/28/2010 MRS Initial
-----------------------------------------------------------------------------------------
	Insert into dbo.SIAdmin_AuditLog(UserName,StoredProcedureName,ParameterList,ExecuteDateTime,Comment) 
	Values( SUSER_NAME() , OBJECT_NAME(@@PROCID) ,'ClientID = ' + CAST(@ClientID AS varchar) + ', RecordDateTime = ' + CONVERT(VARCHAR, @RecordDateTime, 120), GetDate(), @Comment)

	INSERT CrawlRecord (ItemID, ClientID, SEID, RecordDateTime, ProcessDateTime, CrawlRecordTypeID, CrawlRecordStatusID, CrawlTypeID) 
	VALUES (@ClientID, @ClientID, 0, @RecordDateTime, null, 0, 0, 39) 
		
END

GRANT EXECUTE ON [SIAdmin].[SI_SP_DFA_Data_Regrab] TO [SEARCHIGNITE\SI Tech Services Tier 1] AS [dbo]
GRANT EXECUTE ON [SIAdmin].[SI_SP_DFA_Data_Regrab] TO [SEARCHIGNITE\SI Tech Services Tier 2] AS [dbo]