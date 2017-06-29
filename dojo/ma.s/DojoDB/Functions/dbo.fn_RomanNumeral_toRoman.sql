SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE function [dbo].[fn_RomanNumeral_toRoman] (@num INT)
RETURNS VARCHAR(255)
AS
/*
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Change History
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
05/10/2012 MRS Initial
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT dbo.fn_RomanNumeral_toRoman( 5280)

*/
BEGIN
	DECLARE @Roman VARCHAR(255) = ''
	
	WHILE @num > 0 
	BEGIN

		IF @num >= 1000
		BEGIN
			SET @Roman += 'M'
			SET @num -= 1000
		END
		ELSE IF @num >= 900
		BEGIN
			SET @Roman += 'CM'
			SET @num -= 900
		END
		ELSE IF @num >= 500 
		BEGIN
			SET @Roman += 'D'
			SET @num -= 500
		END
		ELSE IF @num >= 400 
		BEGIN
			SET @Roman += 'CD'
			SET @num -= 400
		END
		ELSE IF @num >= 100 
		BEGIN
			SET @Roman += 'C'
			SET @num -= 100
		END
		ELSE IF @num >= 90 
		BEGIN
			SET @Roman += 'XC'
			SET @num -= 90
		END
		ELSE IF @num >= 50 
		BEGIN
			SET @Roman += 'L'
			SET @num -= 50
		END
		ELSE IF @num >= 40 
		BEGIN
			SET @Roman += 'XL'
			SET @num -= 40
		END
		ELSE IF @num >= 10 
		BEGIN
			SET @Roman += 'X'
			SET @num -= 10
		END
		ELSE IF @num >= 9 
		BEGIN
			SET @Roman += 'IX'
			SET @num -= 9
		END
		ELSE IF @num >= 5 
		BEGIN
			SET @Roman += 'V'
			SET @num -= 5
		END
		ELSE IF @num >= 4 
		BEGIN
			SET @Roman += 'IV'
			SET @num -= 4
		END
		ELSE IF @num >= 1 
		BEGIN
			SET @Roman += 'I'
			SET @num -= 1
		END

	END

	RETURN @Roman
END

GO
