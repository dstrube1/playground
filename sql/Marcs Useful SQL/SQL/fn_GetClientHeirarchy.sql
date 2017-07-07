USE [SearchIgnite]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetClientHeirarchy]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_GetClientHeirarchy]
GO

USE [SearchIgnite]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_GetClientHeirarchy] (@ClientID INT, @Level TINYINT = 0)
RETURNS @CLient_Heirarchy TABLE (
				ClientID INT,
				ClientName VARCHAR(MAX), 
				ParentClient INT,
				LevelID TINYINT
)
AS
/*
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Change History
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
04/04/2011 MRS Initial- Created function to Get Client Heirarchy
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM fn_GetClientHeirarchy(3233,0)
*/
BEGIN
	  DECLARE @ParentClientID INT,
			@ClientName VARCHAR(MAX)
			
	
	SELECT @ParentClientID = ParentClientID, 
		@ClientName = ClientName,
		@Level = @Level + 1
	FROM CLients 
	WHERE CLientID = @ClientID
	
	INSERT INTO @CLient_Heirarchy
	SELECT @ClientID,@ClientName,@ParentClientID,@Level

	
	IF @ParentCLientID <> 1
	BEGIN
		INSERT INTO @CLient_Heirarchy
		SELECT * FROM dbo.fn_GetClientHeirarchy(@ParentClientID, @Level)
	END	
	
	RETURN 
END

GO
