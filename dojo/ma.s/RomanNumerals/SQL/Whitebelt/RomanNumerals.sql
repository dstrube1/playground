

DECLARE @num INT = 50,
	@Roman_expected VARCHAR(256) = 'L',
	@Roman VARCHAR(256) = 'CMXLIV',
	@num_expected INT = 944,
	@Direction BIT = 0,
	@IncludeTest BIT = 1

IF @Direction = 0
BEGIN
	
	SET @Roman = ''
	
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

	RAISERROR('%s',0,1,@Roman)
	
	IF @IncludeTest = 1
		IF @Roman = @Roman_expected 
				AND @Roman IS NOT NULL
			RAISERROR('Test Passed',0,1)
		ELSE IF @num_expected IS NULL	
			RAISERROR('Please provide Expected Value',0,1)
		ELSE
			RAISERROR('Please Check input values',0,1)
	
	
END

ELSE
BEGIN

	SET @num = 0

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

	RAISERROR('%d',0,1,@num)
	
	IF @IncludeTest = 1
		IF @num = @num_expected 
				AND @num_expected IS NOT NULL
			RAISERROR('Test Passed',0,1)
		ELSE IF @num_expected IS NULL	
			RAISERROR('Please provide Expected Value',0,1)
		ELSE
			RAISERROR('Please Check input values',0,1)

END


