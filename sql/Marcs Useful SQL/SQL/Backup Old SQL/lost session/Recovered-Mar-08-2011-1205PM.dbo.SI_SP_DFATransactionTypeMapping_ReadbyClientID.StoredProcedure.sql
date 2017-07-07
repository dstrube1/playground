USE [SearchIgnite]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_DFATransactionTypeMapping_ReadByClientID]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_DFATransactionTypeMapping_ReadByClientID]
GO

USE [SearchIgnite]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SI_SP_DFATransactionTypeMapping_ReadByClientID]
@MasterClientID INT
AS
/*
03/07/2011 MRS 4.8 Change to read Action types from MasterClientID

[SI_SP_DFATransactionTypeMapping_ReadByClientID] 3830
*/
BEGIN
	SET NOCOUNT ON
	SELECT dm.ClientID, 
		ActionType, 
		ActionName, 
		dm.CustomerTransactionTypeID, 
		DFAActionId, 
		CustomerTransactionName
	FROM dbo.DFATransactionTypeMapping dm 
		LEFT JOIN dbo.v_ClientCustomerTransactionType ct ON ct.ClientID = dm.ClientID 
			AND ct.CustomerTransactionTypeID = dm.CustomerTransactionTypeID 
			AND IsPrimaryOwner = 1
	WHERE dm.ClientID IN (SELECT ClientID FROM External_AdvertiserClient_Mapping WHERE MasterClientID = @MasterClientID)
END


GO

GRANT EXECUTE ON [dbo].[SI_SP_DFATransactionTypeMapping_ReadByClientID] TO [webaccess] AS [dbo]
GO


