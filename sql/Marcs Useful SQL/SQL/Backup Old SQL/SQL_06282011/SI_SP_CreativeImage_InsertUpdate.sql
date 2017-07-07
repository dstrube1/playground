USE [SearchIgnite]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_CreativeImage_InsertUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_CreativeImage_InsertUpdate]
GO

USE [SearchIgnite]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[SI_SP_CreativeImage_InsertUpdate]
@ImageString image
as
begin

INSERT INTO CreativeImage(Image)	
VALUES(@ImageString)

end

GO

GRANT EXECUTE ON [dbo].[SI_SP_CreativeImage_InsertUpdate] TO [webaccess] AS [dbo]
GO


