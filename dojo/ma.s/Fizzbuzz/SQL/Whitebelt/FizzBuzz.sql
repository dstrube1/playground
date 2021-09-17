

DECLARE @Start TINYINT = 1,
	@End TINYINT = 100,
	@Stage BIT = 0 --Stage 1 =0 Stage 2 = 1
	
IF @Stage = 0
	WHILE @Start <= @End
	BEGIN

		IF(@Start%3 = 0 AND @Start%5 <> 0)
			RAISERROR('Fizz',0,1) WITH NOWAIT
		ELSE IF (@Start%3 <> 0 AND @Start%5 = 0)
			RAISERROR('Buzz',0,1) WITH NOWAIT
		ELSE IF (@Start%3 = 0 AND @Start%5 = 0)
			RAISERROR('FizzBuzz',0,1) WITH NOWAIT
		ELSE
			RAISERROR('%d',0,1, @Start) WITH NOWAIT

		SET @Start +=1

	END
ELSE
	WHILE @Start <= @End
	BEGIN

		IF(@Start%5 <> 0
				AND (@Start%3 = 0 
						OR CHARINDEX('3',CAST(@Start AS VARCHAR(10))) > 0
					)
			)
			RAISERROR('Fizz',0,1) WITH NOWAIT
		ELSE IF ( @Start%3 <> 0
				AND ( @Start%5 = 0
						OR CHARINDEX('5',CAST(@Start AS VARCHAR(10))) > 0
					)
			)
			RAISERROR('Buzz',0,1) WITH NOWAIT
		ELSE IF (
					(@Start%3 = 0 OR CHARINDEX('3',CAST(@Start AS VARCHAR(10))) > 0)
					AND 
					(@Start%5 = 0 OR CHARINDEX('5',CAST(@Start AS VARCHAR(10))) > 0)
				)
			RAISERROR('FizzBuzz',0,1) WITH NOWAIT
		ELSE
			RAISERROR('%d',0,1, @Start) WITH NOWAIT

		SET @Start +=1

	END

