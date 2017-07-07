SELECT  *
FROM    SIProcessing_CacheHistory..TrackedCache tt
WHERE   tt.ClientID = 754
        AND tt.EasternCreateDate >= 'Sep 10 2012 12:00AM'
        AND tt.EasternCreateDate < 'Sep 12 2012 12:00AM'
        AND tt.CustomerTransactionTypeID IN ( 1356 )
        AND ChannelID = 1
        