exec SI_SP_BulkSheetQueue_InsertUpdate @IncludeRptData=N'0',@UserId=N'3118',@ModifiedBy=N'3118',@LUTimeFrameID=N'1',@BulkSheetStatusID=N'1',@BulkSheetRequestCriteria=N'<?xml version="1.0"?>
<ArrayOfBulkRequestCriteriaBaseBO xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BulkRequestCriteriaBaseBO xsi:type="BulkRequestCriteriaStatusBO">
    <LevelId>2</LevelId>
    <StatusChangeTo>1</StatusChangeTo>
  </BulkRequestCriteriaBaseBO>
</ArrayOfBulkRequestCriteriaBaseBO>',
@BulkSheetFilter=N'<si><advancedfilter publisherfiltertypeid="2" publisherfiltertype="campaign"><filterelement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" publisherfiltertypeid="2" filterelementid="0" filtertypeid="1"
 filtertype="Status" filteroperatorid="5" datagridcolumnid="161" description="&lt;span fontWeight=''bold''&gt;Campaign: Status &lt;/span&gt;is ''''&lt;span fontWeight=''bold''&gt;Active&lt;/span&gt;''''"><values><value>1</value></values><bidrules /><optgroups /></filterelement></advancedfilter><advancedfilter publisherfiltertypeid="5"
  publisherfiltertype="keyword"><filterelement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" publisherfiltertypeid="5" filterelementid="1" filtertypeid="4" filtertype="Performance" filteroperatorid="1" datagridcolumnid="94" datafield="CPA" description="&lt;span fontWeight=''bold''&gt;Keyword: CPA&lt;/span&gt; is greater than ''''&lt;span fontWeight=''bold''&gt;50&lt;/span&gt;'''' (over currently selected date range)"><values><value>50</value></values><bidrules /><optgroups /></filterelement></advancedfilter></si>',@ReportDataStartDate=N'7/20/2010 4:39:19 PM',@CurrencyId=N'73',@ClientId=N'76',@ReportDataEndDate=N'7/27/2010 4:39:19 PM',@BulkSheetTypeID=N'1',@CultureCode=N'en-US',@EmailAddress=N'super@searchignite.com',@DisplayName=N'capaign_trace'
 
 BulkSheetQueueID
455

exec SI_SP_BulkSheetQueueSearchEngineCampaignGroup_Insert @BulkSheetQueueID=N'455',@SeId=N'1'
exec SI_SP_BulkSheetQueueItems_InsertUpdate @BulkSheetQueueID=N'455',@SpreadSheetID=N'1'
exec SI_SP_BulkSheetQueue_Read @BulkSheetQueueId=N'454'
exec SI_SP_BulkSheetQueueItems_ReadByBulkSheetQueueID @BulkSheetQueueID=N'454'