DECLARE @ll_assessment_id varchar(40)

DECLARE allergies CURSOR FAST_FORWARD FOR SELECT assessment_id FROM c_assessment_definition WHERE assessment_type = 'Allergy' --FOR READ ONLY 
OPEN allergies
FETCH NEXT FROM allergies INTO @ll_assessment_id 
WHILE (@@fetch_status<>-1)
	BEGIN
	PRINT @ll_assessment_id + ';'--SELECT distinct cpr_id 
	--	from p_assessment 
	--	where assessment_id = @ll_assessment_id 
	FETCH NEXT FROM allergies INTO @ll_assessment_id 
	END
CLOSE allergies
DEALLOCATE allergies