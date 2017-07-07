USE [SIProcessing]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_LookupUSDCurrencyExchangeRate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_LookupUSDCurrencyExchangeRate]
GO

USE [SIProcessing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[fn_LookupUSDCurrencyExchangeRate] (@FromCurrencyID INT, @EffectiveDate DATETIME)  
RETURNS FLOAT
AS  
BEGIN 
 -- Base Impressions Function
 -- This should be coded as a function 
 -- that is passed in a cskid and seid
 -- and returns a single float value
 declare @ExchangeRate FLOAT
 
 SELECT
		@ExchangeRate = ExchangeRate
	FROM
		dbo.CurrencyExchangeDataHistory
	WHERE
		FromCurrencyID = @FromCurrencyID
		AND ToCurrencyID = (SELECT CurrencyID FROM dbo.LUCurrency WHERE CurrencyCode = 'USD')
		AND DATEDIFF(d, @EffectiveDate, CreateDate) = 0;

	IF @ExchangeRate IS NULL
			SELECT
				@ExchangeRate = CAST(AVG(ExchangeRate) AS FLOAT)
			FROM
				dbo.CurrencyExchangeDataHistory
			WHERE
				FromCurrencyID = @FromCurrencyID
				AND ToCurrencyID = (SELECT CurrencyID FROM dbo.LUCurrency WHERE CurrencyCode = 'USD')
				AND CreateDate BETWEEN DATEADD(d, -7, @EffectiveDate) AND DATEADD(d, 7, @EffectiveDate)
				
				
  return (@ExchangeRate)
END

GO


