SELECT DISTINCT
        REPLACE(REPLACE(( SUBSTRING(ReportProcessorInfoXML,
                                    CHARINDEX('<StoredProcedures>', ReportProcessorInfoXML),
                                    LEN(ReportProcessorInfoXML)
										- CHARINDEX(REVERSE('</StoredProcedures>'), REVERSE(ReportProcessorInfoXML))
													- CHARINDEX('<StoredProcedures>', ReportProcessorInfoXML)
													+ LEN('</StoredProcedures>')
                                                ) ),
                        '</StoredProcedures>', ''), '<StoredProcedures>', '')
FROM    dbo.ReportType

--sp_helptext 'SI_SP_RPT_PS_Summary_SearchQueryPerformance_Read'
