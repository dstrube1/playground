SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE function [dbo].[fn_RomanNumeral_toINT] (@Roman VARCHAR(255))
RETURNS INT
AS
/*
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Change History
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
05/10/2012 MRS Initial
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT dbo.fn_RomanNumeral_toINT('MM')

*/
BEGIN
	DECLARE @num INT = 0

	WHILE LEN(@roman) > 0 
	BEGIN

		IF CHARINDEX('M',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 1)
			SET @num += 1000
		END
		ELSE IF CHARINDEX('CM',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 2)
			SET @num += 900
		END
		ELSE IF CHARINDEX('D',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 1)
			SET @num += 500
		END
		ELSE IF CHARINDEX('CD',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 2)
			SET @num += 400
		END
		ELSE IF CHARINDEX('C',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 1)
			SET @num += 100
		END
		ELSE IF CHARINDEX('XC',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 2)
			SET @num += 90
		END
		ELSE IF CHARINDEX('L',@Roman) = 1 
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 1)
			SET @num += 50
		END
		ELSE IF CHARINDEX('XL',@Roman) = 1 
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 2)
			SET @num += 40
		END
		ELSE IF CHARINDEX('X',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 1)
			SET @num += 10
		END
		ELSE IF CHARINDEX('IX',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 2)
			SET @num += 9
		END
		ELSE IF CHARINDEX('V',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 1)
			SET @num += 5
		END
		ELSE IF CHARINDEX('IV',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 2)
			SET @num += 4
		END
		ELSE IF CHARINDEX('I',@Roman) = 1
		BEGIN
			SET @Roman = RIGHT(@Roman, LEN(@roman) - 1)
			SET @num += 1
		END

	END

	RETURN @num
END

GO
