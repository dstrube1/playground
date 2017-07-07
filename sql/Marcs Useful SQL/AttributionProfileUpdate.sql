
SET NOCOUNT ON
-- Need to add code for Channel Table insert
/*
DECLARE @Clients TABLE(
	ClientID INT,
	isProcessed BIT,
	PRIMARY KEY CLUSTERED (isProcessed,ClientID)
)

DECLARE @ClientID INT,
	@Base_clientID INT = 7116,
	@ProfileSequenceID TINYINT= 2,
	@AttributionModelID TINYINT = 3, /*SELECT * FROM Searchignite..LUAttributionModel*/
	@ClientAttributionProfileChannelXML XML = '<CHANNELPRIORITIES><CHANNELPRIORITY TIER="1" PRIORITY="1" CHANNELID="1" EXPOSURETYPEID="1" ACTIONWEIGHTPCT="100" LOOKBACKWINDOWINDAYS="30" /><CHANNELPRIORITY TIER="1" PRIORITY="2" CHANNELID="3" EXPOSURETYPEID="1" ACTIONWEIGHTPCT="100" LOOKBACKWINDOWINDAYS="30" /><CHANNELPRIORITY TIER="1" PRIORITY="3" CHANNELID="4" EXPOSURETYPEID="1" ACTIONWEIGHTPCT="100" LOOKBACKWINDOWINDAYS="30" /><CHANNELPRIORITY TIER="2" PRIORITY="1" CHANNELID="5" EXPOSURETYPEID="1" ACTIONWEIGHTPCT="100" LOOKBACKWINDOWINDAYS="30" /><CHANNELPRIORITY TIER="2" PRIORITY="2" CHANNELID="6" EXPOSURETYPEID="1" ACTIONWEIGHTPCT="100" LOOKBACKWINDOWINDAYS="30" /><CHANNELPRIORITY TIER="3" PRIORITY="1" CHANNELID="2" EXPOSURETYPEID="1" ACTIONWEIGHTPCT="100" LOOKBACKWINDOWINDAYS="30" /><CHANNELPRIORITY TIER="4" PRIORITY="1" CHANNELID="6" EXPOSURETYPEID="2" ACTIONWEIGHTPCT="100" LOOKBACKWINDOWINDAYS="30" /><CHANNELPRIORITY TIER="4" PRIORITY="2" CHANNELID="4" EXPOSURETYPEID="2" ACTIONWEIGHTPCT="100" LOOKBACKWINDOWINDAYS="30" /></CHANNELPRIORITIES>',
	@T2_Count INT = 0,
	@T1_Count INT = 0,
	@ClientAttributionProfileID INT 

INSERT INTO @Clients( ClientID, isProcessed )
SELECT ClientID, 0
FROM Searchignite..tn_ClientHierarchy_Active(1862) c
WHERE EXISTS ( 
		SELECT 1 
		FROM Searchignite..Clients 
		WHERE StatusFlag = 1
			AND ClientLevelID = 1
			AND c.ClientID = ClientID
)
AND c.ClientID <> 7116

WHILE EXISTS (SELECT TOP 1 1 FROM @Clients WHERE isProcessed = 0 )
BEGIN

	SELECT TOP 1 @ClientID = ClientID FROM @Clients WHERE isProcessed = 0
	
		SELECT @T1_Count = COUNT(1) 
		FROM Searchignite..ClientAttributionProfileSetting
		WHERE ClientID = @ClientID
			AND ProfileSequence = @ProfileSequenceID
			AND RecordStatus = 'A'
			AND AttributionModelID = @AttributionModelID --Last
		
		IF @T1_Count = 0
		BEGIN
			
			RAISERROR('Creating Profile for Client (%d)',0,1, @ClientID) WITH NOWAIT
		
			INSERT INTO Searchignite..ClientAttributionProfile( ClientID, CreateDateUTC )
			SELECT @ClientID, GETUTCDATE()
			
			SET @ClientAttributionProfileID = SCOPE_IDENTITY()
			
			INSERT INTO Searchignite..ClientAttributionProfileSetting
			        ( ClientAttributionProfileID,ClientID,ProfileName,AttributionModelID,CustomAttributionSettingID,CustomAttributionFactor,IncludeAffiliatedExposure,UserID,CreateDateUTC ,RecordStatus,EffectiveBeginDateUTC,ProfileSequence)
			SELECT @ClientAttributionProfileID,@ClientID,ProfileName,AttributionModelID,CustomAttributionSettingID,CustomAttributionFactor,IncludeAffiliatedExposure,UserID,GETUTCDATE() ,'A',GETUTCDATE(), @ProfileSequenceID
			FROM Searchignite..ClientAttributionProfileSetting
			WHERE ClientID = @Base_clientID
				AND ProfileSequence = @ProfileSequenceID
				AND RecordStatus = 'A'
			
			INSERT INTO Searchignite..ClientAttributionProfileSettingHistory (
			        ClientAttributionProfileID ,
			        ClientID ,
			        ProfileName ,
			        AttributionModelID ,
			        CustomAttributionSettingID ,
			        CustomAttributionFactor ,
			        IncludeAffiliatedExposure ,
			        UserID ,
			        CreateDateUTC ,
			        RecordStatus ,
			        ClientAttributionProfileChannelXML ,
			        ProfileSequence 
			        )
			SELECT  @ClientAttributionProfileID ,
			        @ClientID ,
			        ProfileName ,
			        AttributionModelID ,
			        CustomAttributionSettingID ,
			        CustomAttributionFactor ,
			        IncludeAffiliatedExposure ,
			        UserID ,
			        GETUTCDATE() ,
			        'A' ,
			        @ClientAttributionProfileChannelXML ,
			        @ProfileSequenceID
			FROM Searchignite..ClientAttributionProfileSettingHistory
			WHERE ClientID = @Base_clientID
				AND ProfileSequence = @ProfileSequenceID
				AND RecordStatus = 'A'
		/**/
		END	

		IF @T1_Count > 1
		SELECT * 
		FROM Searchignite..ClientAttributionProfileSetting
		WHERE ClientID = @ClientID
		AND ProfileSequence = @ProfileSequenceID
		AND RecordStatus = 'A'
	
	--Searchignite..ClientAttributionProfileSettingHistory
		IF @T1_Count > 0
		BEGIN 
			SELECT @T2_Count = COUNT(1) 
			FROM Searchignite..ClientAttributionProfileSettingHistory
			WHERE ClientID = @ClientID
			AND ProfileSequence = @ProfileSequenceID
			AND RecordStatus = 'A'
			--AND AttributionModelID = @AttributionModelID
		
		IF @T2_Count > 1
			WITH Multiple_Active AS(
				SELECT ClientAttributionProfileSettingHistoryID, ROW_NUMBER() OVER (ORDER BY AttributionModelID DESC, ClientAttributionProfileSettingHistoryID DESC) RNUM
				FROM Searchignite..ClientAttributionProfileSettingHistory
				WHERE ClientID = @ClientID
				AND ProfileSequence = @ProfileSequenceID
				AND RecordStatus = 'A'
			)	
			UPDATE c
			SET RecordStatus = 'P'
			--SELECT * 
			FROM Searchignite..ClientAttributionProfileSettingHistory c
			WHERE EXISTS (SELECT 1 FROM Multiple_Active WHERE RNUM > 1 AND ClientAttributionProfileSettingHistoryID = c.ClientAttributionProfileSettingHistoryID)

		IF @T2_Count = 1
		UPDATE c
		SET ClientAttributionProfileChannelXML = @ClientAttributionProfileChannelXML
		FROM Searchignite..ClientAttributionProfileSettingHistory c
		WHERE ClientID = @ClientID
			AND ProfileSequence = @ProfileSequenceID
			AND RecordStatus = 'A'

	END	
		
	RAISERROR('Client(%d) Complete',0,1,@ClientID) WITH NOWAIT
	
	UPDATE @Clients
	SET isProcessed = 1
	WHERE isProcessed = 0
		AND ClientID = @ClientID
	
	

END
*/