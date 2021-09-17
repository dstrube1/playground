SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[SP_FizzBuzz] (@Start INT, @End INT, @Stage BIT) AS
/*
---------------------------------------------------------------------
Change History
---------------------------------------------------------------------
05/10/2012	MRS	Initial
---------------------------------------------------------------------

EXEC SP_FizzBuzz @Start =1, @End =100, @Stage = 0

*/
BEGIN

	SET NOCOUNT ON

	DECLARE @tmp TABLE(
		RowNum INT IDENTITY(1,1),
		col1 VARCHAR(255)
	)
		
	IF @Stage = 0
		WHILE @Start <= @End
		BEGIN

			IF(@Start%3 = 0 AND @Start%5 <> 0)
				INSERT INTO @tmp (  col1 )
				VALUES  ('Fizz')
			ELSE IF (@Start%3 <> 0 AND @Start%5 = 0)
				INSERT INTO @tmp (  col1 )
				VALUES  ('Buzz')
			ELSE IF (@Start%3 = 0 AND @Start%5 = 0)
				INSERT INTO @tmp (  col1 )
				VALUES  ('FizzBuzz')
			ELSE
				INSERT INTO @tmp (  col1 )
				SELECT CAST(@Start AS VARCHAR(255))

			SET @Start +=1

		END
	ELSE
		WHILE @Start <= @End
		BEGIN

			IF(
					(@Start%5 <> 0 
						AND CHARINDEX('5',CAST(@Start AS VARCHAR(10))) = 0
					)
					AND 
					(@Start%3 = 0 
						OR CHARINDEX('3',CAST(@Start AS VARCHAR(10))) > 0
					)
				)
				INSERT INTO @tmp (  col1 )
				VALUES  ('Fizz')
			ELSE IF (
					(@Start%3 <> 0 
						AND CHARINDEX('3',CAST(@Start AS VARCHAR(10))) = 0
					)
					AND ( @Start%5 = 0
							OR CHARINDEX('5',CAST(@Start AS VARCHAR(10))) > 0
						)
				)
				INSERT INTO @tmp (  col1 )
				VALUES  ('Buzz')
			ELSE IF (
						(@Start%3 = 0 OR CHARINDEX('3',CAST(@Start AS VARCHAR(10))) > 0)
						AND 
						(@Start%5 = 0 OR CHARINDEX('5',CAST(@Start AS VARCHAR(10))) > 0)
					)
				INSERT INTO @tmp (  col1 )
				VALUES  ('FizzBuzz')
			ELSE
				INSERT INTO @tmp (  col1 )
				SELECT CAST(@Start AS VARCHAR(255))

			SET @Start +=1

		END


	SELECT * 
	FROM @tmp

END
GO
