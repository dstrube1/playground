SELECT * 
FROM Staging_Bid_02222012
WHERE CSKID = 10720282 

select bh.* 
from Searchignite..BidHistory bh 
join Searchignite..CSKeywords csk 
on csk.CSKID = bh.CSKID 
where csk.clientid = 1637 
and bh.CSKID = 10720282 
AND bh.CreateDate >= DATEADD(hh,24,'2012-01-07 11:31:51.000')
	AND bh.CreateDate < '02/20/2012' -- FixDate


IF OBJECT_ID('tempdb..#BH') IS NOT NULL
DROP TABLE #BH

CREATE TABLE #BH(
	BidHistoryID INT
)

INSERT INTO #BH ( BidHistoryID )
SELECT BidHistoryID 
FROM Searchignite..BidHistory bh WITH (NOLOCK)
JOIN JunkDB..Staging_Bid_02222012 sb ON bh.CSKID = sb.CSKID
	AND bh.CreateDate >= DATEADD(hh,24,sb.FileDate) 
	AND bh.CreateDate < '02/20/2012' -- FixDate
	AND bh.FinalBid = sb.Bid


CREATE CLUSTERED INDEX CX_#BH_BidHistoryID ON #BH(BidHistoryID )

select bh.* 
from Searchignite..BidHistory bh 
join #BH ON bh.BidHistoryID = #BH.BidHistoryID 

