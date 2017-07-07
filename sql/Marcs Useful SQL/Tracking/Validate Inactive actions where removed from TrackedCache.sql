

DECLARE @DDiff INT,
	@debug BIT = 1

DECLARE @TA TABLE(
	CreateDateUTC DATETIME,
	InvalidCount INT,
	PRIMARY KEY CLUSTERED (CreateDateUTC)
)

DECLARE @P TABLE (
	PNUM INT,
	isProcessed BIT,
	PRIMARY KEY CLUSTERED (isProcessed, PNum)
)

DECLARE @PNUM INT

INSERT INTO @P( PNUM, isProcessed )
SELECT  DISTINCT p.partition_number,0
	FROM SIProcessing_Attribution.sys.partitions p
	WHERE p.object_id = OBJECT_ID('SIProcessing_Attribution..TrackedAction')
	AND ROWS > 0
	
WHILE EXISTS(SELECT TOP 1 1 FROM @P WHERE isProcessed = 0)
BEGIN

	SELECT TOP 1 @PNUM = PNUM FROM @P WHERE isProcessed = 0
	
	INSERT INTO @TA( CreateDateUTC, InvalidCount )
	SELECT CAST(CreateDateUTC AS DATE),COUNT(1)
	FROM SIProcessing_Attribution..TrackedAction ta WITH (NOLOCK)
	WHERE SIProcessing_Attribution.$PARTITION.PF_SI_TrackedAction(CreateDateUTC) = @PNUM
		AND RecordStatus = 'I'
		AND EXISTS(SELECT 1 FROM SIProcessing_CacheHistory..TrackedCache WITH (NOLOCK) WHERE TrackedActionID = ta.TrackedActionID AND EasternCreateDate = ta.LocalizedCreateDate)
	GROUP BY CAST(CreateDateUTC AS DATE)
	
	IF @@ROWCOUNT > 0 AND @debug = 0
		UPDATE ta
		SET EffectiveEndDateUTC = GETUTCDATE()
		FROM SIProcessing_Attribution..TrackedAction ta
		WHERE SIProcessing_Attribution.$PARTITION.PF_SI_TrackedAction(CreateDateUTC) = @PNUM
			AND RecordStatus = 'I'
			AND EXISTS(SELECT 1 FROM SIProcessing_CacheHistory..TrackedCache WHERE TrackedActionID = ta.TrackedActionID AND EasternCreateDate = ta.LocalizedCreateDate)
	
	UPDATE @P
	SET isProcessed = 1
	WHERE isProcessed = 0
		AND PNUM = @PNUM
		
END

SELECT * FROM @TA


IF @debug = 0
BEGIN

	SELECT TOP 1 @DDiff = DATEDIFF(dd,CreateDateUTC ,GETUTCDATE()) + 1
	FROM @TA
	ORDER BY CreateDateUTC

	IF @DDiff >= 30
		exec SIProcessing_CacheHistory..SI_SP_ExposureSequence_Delete @InactiveActionDays=  @DDiff

END

