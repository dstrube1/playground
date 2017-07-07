--DECLARE           @batched          int,
--                  @max              int,
--                  @current          int
                  
--SET @current = (Select MIN(URL_ID) FROM [JunkDB].[dbo].[RedirectURL_TEMP])    
--SET @batched = @current + 10000
--SET @max = (Select MAX(URL_ID) FROM [JunkDB].[dbo].[RedirectURL_TEMP])

--WHILE (@current < @max)
--BEGIN
--      BEGIN TRAN
--            SELECT @current, @batched, @max
--            UPDATE [Searchignite].[dbo].CSKeywords
--            SET RedirectURL = t.RedirectURL,
--                UpdateDate = getutcdate()
--            From [Searchignite].[dbo].CSKeywords ck join [JunkDB].[dbo].[RedirectURL_TEMP] t        
--            on ck.CSKID= t.cskid and ck.ClientID= t.clientID 
--            where t.URL_ID between @current and @batched
            
--            UPDATE [JunkDB].[dbo].[RedirectURL_TEMP]
--            SET IsProcessed = 1
--            where URL_ID between @current and @batched
--      COMMIT            
--       SET @current = @batched
--       SET @batched = @current + 10000

--END


sp_who4

SElect * from [Searchignite].[dbo].CSKeywords WHERE RedirectURL = 'test'
SELECT * FROm .[Searchignite].[dbo].CSKeywords ck join [JunkDB].[dbo].[RedirectURL_TEMP] t ON t.cskid = ck.CSKID