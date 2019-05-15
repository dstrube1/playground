SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[SP_RomanNumeral_Test] AS
BEGIN
/*
------------------------------------------------------------
Change History
------------------------------------------------------------
05/10/2012 MRS Initial
------------------------------------------------------------
Stored Procedure to test Roman Numeral Conversion functions
*/
	SET NOCOUNT ON 

	DECLARE @num INT ,
		@Roman VARCHAR(256) ,
		@Direction BIT,
		@debug BIT =0
		
		
	DECLARE @tmp TABLE(
		num INT,
		Roman_expected VARCHAR(256),
		Roman VARCHAR(256),
		num_expected INT,
		Direction BIT,
		TestResults BIT DEFAULT 0,
		Results_expected BIT,
		Processed BIT DEFAULT 0
	)

	INSERT INTO @tmp ( num , Roman_expected ,  Roman , num_expected ,Direction, Results_expected )
	VALUES  
		-- Num to Roman --Pass
		( 1 , 'I' , NULL , NULL,0,1 ),
		( 2 , 'II' , NULL , NULL,0,1 ),
		( 3 , 'III' , NULL , NULL,0,1 ),
		( 4 , 'IV' , NULL , NULL,0,1 ),
		( 5 , 'V' , NULL , NULL,0,1 ),
		( 7 , 'VII' , NULL , NULL,0,1 ),
		( 9 , 'IX' , NULL , NULL,0,1 ),
		( 10 , 'X' , NULL , NULL,0,1 ),
		( 5280 , 'MMMMMCCLXXX' , NULL , NULL,0,1 ),

		-- Roman to Num --Pass
		( NULL , NULL , 'I' , 1,1,1 ),
		( NULL , NULL , 'II' , 2,1,1 ),
		( NULL , NULL , 'III' , 3,1,1 ),
		( NULL , NULL , 'IV' , 4,1,1 ),
		( NULL , NULL , 'V' , 5,1,1 ),
		( NULL , NULL , 'XI' , 11,1,1 ),
		( NULL , NULL , 'CXX' , 120,1,1 ),
		( NULL , NULL , 'MMMMMCCLXXX' , 5280,1,1 ),
		
		-- Num to Roman --FAIL
		( 1 , 'M' , NULL , NULL,0,0 ),
		( 1 , 'II' , NULL , NULL,0,0 ),

		-- Roman to Num --Fail
		( NULL , NULL , 'I' , 5280,1,0 ),
		( NULL , NULL , 'IX' , 2,1,0 )


	WHILE EXISTS(SELECT TOP 1 1 FROM @tmp WHERE Processed = 0)
	BEGIN
		SELECT TOP 1  @num = num ,
				@Roman = Roman ,
				@Direction = Direction  
		FROM @tmp WHERE Processed = 0

		IF @Direction = 0 AND @num IS NOT NULL
			UPDATE @tmp
			SET  Roman = dbo.fn_RomanNumeral_toRoman(@num),
				Processed = 1
			WHERE Direction  = 0
				AND num = @num

		IF @Direction = 1 AND @Roman IS NOT NULL
			UPDATE @tmp
			SET  num = dbo.fn_RomanNumeral_toInt(@Roman),
				Processed = 1
			WHERE Direction  = 1
				AND Roman = @Roman

	END

	UPDATE @tmp
	SET TestResults = 1
	WHERE Roman = Roman_expected
		AND Direction = 0
		
	UPDATE @tmp
	SET TestResults = 1
	WHERE num = num_expected
		AND Direction = 1

	IF @debug = 1
		SELECT * FROM @tmp

	IF EXISTS(SELECT TOP 1 1 FROM @tmp WHERE TestResults <> Results_expected)
	BEGIN

		RAISERROR('Test Failed',0,1)
		
		SELECT * 
		FROM @tmp 
		WHERE TestResults <> Results_expected
		
	END

	ELSE
		RAISERROR('All Test Passed',0,1)
	
	
END
GO
