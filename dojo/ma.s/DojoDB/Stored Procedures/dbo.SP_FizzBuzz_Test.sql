SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[SP_FizzBuzz_Test](@debug BIT = 0 )AS
/*
---------------------------------------------------------------------
Change History
---------------------------------------------------------------------
05/10/2012	MRS	Initial
---------------------------------------------------------------------
EXEC SP_FizzBuzz_Test @debug = 1

*/
BEGIN

	SET NOCOUNT ON
	
	DECLARE @Start INT =1,
		@end INT = 100
	
	DECLARE @Stage1 TABLE(
		Rownum INT,
		col1 VARCHAR(256)
	)
	
	DECLARE @Stage2 TABLE(
		Rownum INT,
		col1 VARCHAR(256)
	)
	
	DECLARE @test TABLE(
		RowNum INT,
		Stage BIT, --0 is Stage 1, 1 is stage 2
		ExpectedAnswer VARCHAR(256),
		Result BIT DEFAULT 0,
		ExpectedResult BIT
	)
	
	INSERT INTO @test
	        ( RowNum ,
	          Stage ,
	          ExpectedAnswer ,
	          ExpectedResult
	        )
	VALUES  
		--Stage 1 Test Pass
		 ( 1,0,'1',1),
		 ( 3,0,'Fizz',1),
		 ( 5,0,'Buzz',1),
		 ( 15,0,'FizzBuzz',1),
		 ( 18,0,'Fizz',1),
		 ( 25,0,'Buzz',1),
		 ( 31,0,'31',1),
		 
		--Stage 2 Test Pass
		 ( 3,1,'Fizz',1),
		 ( 5,1,'Buzz',1),
		 ( 15,1,'FizzBuzz',1),
		 ( 18,1,'Fizz',1),
		 ( 25,1,'Buzz',1),
		 ( 31,1,'Fizz',1),
		 ( 35,1,'FizzBuzz',1),
		 ( 41,1,'41',1),
		 ( 51,1,'FizzBuzz',1),
		 ( 53,1,'FizzBuzz',1),
		 ( 55,1,'Buzz',1),
		 
		--Stage 1 Test Fail
		 ( 10,0,'10',0),
		 ( 10,0,'Fizz',0),
		 ( 10,0,'FizzBuzz',0),
		 ( 12,0,'12',0),
		 ( 12,0,'Buzz',0),
		 ( 12,0,'FizzBuzz',0),
		 ( 45,0,'Buzz',0),
		 ( 45,0,'Fizz',0),
		 ( 45,0,'45',0),
		 ( 53,0,'Buzz',0),
		 ( 53,0,'Fizz',0),
		 ( 53,0,'FizzBuzz',0),
		 
		--Stage 2 Test Fail
		 ( 10,1,'10',0),
		 ( 10,1,'Fizz',0),
		 ( 10,1,'FizzBuzz',0),
		 ( 12,1,'12',0),
		 ( 12,1,'Buzz',0),
		 ( 12,1,'FizzBuzz',0),
		 ( 22,1,'Fizz',0),
		 ( 22,1,'Buzz',0),
		 ( 22,1,'FizzBuzz',0),
		 ( 31,1,'31',0),
		 ( 31,1,'Buzz',0),
		 ( 31,1,'FizzBuzz',0),
		 ( 45,1,'Buzz',0),
		 ( 45,1,'Fizz',0),
		 ( 45,1,'45',0),
		 ( 52,1,'FizzBuzz',0),
		 ( 52,1,'Fizz',0),
		 ( 52,1,'51',0),
		 ( 53,1,'Buzz',0),
		 ( 53,1,'Fizz',0),
		 ( 53,1,'53',0)
		 
		 
	INSERT @Stage1 ( Rownum, col1 )
	EXEC dbo.SP_FizzBuzz @Start,@End,0
	
	
	INSERT @Stage2 ( Rownum, col1 )
	EXEC dbo.SP_FizzBuzz @Start,@End,1
	

	UPDATE t
	SET Result = CASE WHEN COALESCE(s1.col1,s2.col1,'') = t.ExpectedAnswer THEN 1 ELSE 0 END
	FROM @test t
	LEFT JOIN @Stage1 s1 ON t.RowNum = s1.Rownum
		AND t.Stage = 0  
	LEFT JOIN @Stage2 s2 ON t.RowNum = s2.Rownum
		AND t.Stage = 1
	
	
	IF EXISTS(SELECT TOP 1 1 FROM @test WHERE ExpectedResult <> Result)
	BEGIN
		SELECT *
		FROM @test t
		LEFT JOIN @Stage1 s1 ON t.RowNum = s1.Rownum
			AND t.Stage = 0  
		LEFT JOIN @Stage2 s2 ON t.RowNum = s2.Rownum
			AND t.Stage = 1  
		WHERE  ExpectedResult <> Result
		
		RAISERROR('Test Failed',0,1) WITH NOWAIT
	END
	
	ELSE
		RAISERROR('All Test Passed',0,1) WITH NOWAIT
		
	IF @debug = 1
		SELECT *
		FROM @test t
		LEFT JOIN @Stage1 s1 ON t.RowNum = s1.Rownum
			AND t.Stage = 0  
		LEFT JOIN @Stage2 s2 ON t.RowNum = s2.Rownum
			AND t.Stage = 1 

END
GO
