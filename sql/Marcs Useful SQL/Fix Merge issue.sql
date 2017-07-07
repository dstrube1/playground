set nocount on
declare 
	@ClientID int,
    @DuplicateTransSeconds_Paid int,
    @StartDate datetime,
    @EndDate datetime,
    @LoopStartdate datetime,
    @LoopEndDate datetime,
    @IgnoreMoreInfo_Paid bit

select  @ClientID = 2537,
        @LoopStartdate = '10/17/2011',
        @LoopEndDate = '10/18/2011'

select  @DuplicateTransSeconds_Paid = DuplicateTransSeconds_Paid,
        @IgnoreMoreInfo_Paid = IgnoreMoreInfo_Paid
from    ClientMailOption
where   ClientID = @ClientID

While @LoopStartdate < @LoopEndDate
    Begin
	--Deal with one day at time
        select  @StartDate = @LoopStartdate,
                @EndDate = DATEADD(dd, 1, @LoopStartDate)

        IF OBJECT_ID('tempdb..#TT') IS NOT NULL 
            DROP TABLE #TT

	--First Find all DFA actions
        select  Dateadd(ss, @DuplicateTransSeconds_Paid, CreateDateUTC) as TransactionDatetime_UBound,
                Dateadd(ss, 0 - @DuplicateTransSeconds_Paid, CreateDateUTC) as TransactionDatetime_lBound,
                CustomerTransactionTypeID,
                TransactionAmount,
                MoreInfo
        into    #TT
        from    TrackedAction
        where   ClientID = @ClientID
                and LocalizedCreateDate >= @StartDate
                and LocalizedCreateDate < @EndDate
                and TrackingSourceID = 3
                and RecordStatus in ( 'A', 'X' ) ;

    --Then find paid action may merged with DFA data
        with    GT
                  as ( select   ta.LocalizedCreateDate,
                                ta.CustomerTransactionTypeID,
                                ta.TransactionAmount,
                                Ta.MoreInfo,
                                ta.RecordStatus,
                                TrackedActionID,
                                ROW_NUMBER() over ( partition by ta.LocalizedCreateDate,
                                                    ta.CustomerTransactionTypeID,
                                                    ta.TransactionAmount,
                                                    Ta.MoreInfo order by RecordStatus, TrackedActionID desc ) as RowNum,
                                DAV,
                                EffectiveBeginDateUTC,
                                EffectiveEndDateUTC
                       from     TrackedAction ta
                                join #TT tt on ta.ClientID in (
                                               select   ClientID
                                               from     dbo.tn_AffiliateClientList_ByClient(@ClientID) )
                                               and ta.CreateDateUTC >= tt.TransactionDatetime_lBound
                                               and ta.CreatedateUTC <= tt.TransactionDatetime_UBound
	--and ta.REcordStatus = 'A'
                                               and ta.CustomerTransactionTypeID = tt.CustomerTransactionTypeID
                                               and ta.TransactionAmount = tt.TransactionAmount
                                               and ta.MoreInfo = case when @IgnoreMoreInfo_Paid = 1 then ta.MoreInfo
                                                                      else tt.MoreInfo
                                                                 end
                                               and ta.TrackingsourceID = 1
                     )
            --Reset latest paid actions back to active if it is not
	Update    TrackedAction
      set       RecordStatus = 'A'
      OUTPUT DELETED.TrackedActionID,'Activate Paid Actions - A-',DELETED.ClientID
				INTO junkDB..DFARemovedActions (TrackedActionID, ACtionType,clientid)
      where     ClientID = @ClientID
                and TrackedActionID in ( select TrackedActionID
                                         from   GT
                                         where  RowNum = 1
                                                and RecordStatus <> 'A' )

	--Change DFA action flag from 'A' to 'X'
        Update  TrackedAction
        set     RecordStatus = 'X',
				EffectiveEndDateUTC = GETUTCDATE()
              OUTPUT DELETED.TrackedActionID,'InActivate DFA Actions -X-',DELETED.ClientID
				INTO junkDB..DFARemovedActions (TrackedActionID, ACtionType, clientid)
        where   ClientID = @ClientID
                and LocalizedCreateDate >= @StartDate
                and LocalizedCreateDate < @EndDate
                and TrackingSourceID = 3
                and RecordStatus = 'A'
	
        select  @LoopStartdate = DATEADD(dd, 1, @LoopStartDate)
    end


--BEGIN TRAN
--UPDATE dbo.TrackedAction
--SET RecordStatus = 'A'
--WHERE RecordStatus = 'x'
--AND EXISTS
--(SELECT 1 FROM junkdb..dfaremovedActions dfa
--WHERE TrackedAction.TrackedActionID = dfa.trackedActionid
--AND dfa.clientid = 1273
--)
--commit

/*update ta
set RecordStatus = 'A'
from TrackedAction ta join #TT tt
on ta.ClientID in (select ClientID from dbo.tn_AffiliateClientList_ByClient (@ClientID))
and ta.CreateDateUTC >= tt.TransactionDatetime_lBound
and ta.CreatedateUTC <= tt.TransactionDatetime_UBound
--and ta.REcordStatus = 'A'
and ta.CustomerTransactionTypeID = tt.CustomerTransactionTypeID
and ta.TransactionAmount = tt.TransactionAmount
and ta.MoreInfo = case when @IgnoreMoreInfo_Paid = 1 then ta.MoreInfo else tt.MoreInfo end
and ta.TrackingsourceID = 1

Update TrackedAction
set RecordStatus = 'X'
where ClientID = 1273
and LocalizedCreateDate >= @StartDate
and LocalizedCreateDate < @EndDate
and TrackingSourceID = 3
and RecordStatus = 'A'

*/
--CREATE TABLE junkDB..DFARemovedActions (TrackedActionID BIGINT, Actiontype VARCHAR(500))

SELECT actiontype, COUNT(1) FROM junkDB..DFARemovedActions
GROUP BY actiontype

--commit

--SELECT * FROM junkDB..DFARemovedActions
--GROUP BY actiontype