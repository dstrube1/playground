
IF EXISTS(select 1
			from sysreferences sr, sysobjects so, sysobjects so2, sysconstraints sc
			where sc.constid  *= sr.constid and
				  sc.constid = so.id and 
				  sc.id = so2.id 
			and so2.name = 'p_Objective_Result_Qualifier'
			and so.name = 'FK_p_Objective_Result_Qua2__13')
	ALTER TABLE dbo.p_Objective_Result_Qualifier DROP
		CONSTRAINT FK_p_Objective_Result_Qua2__13
GO


IF NOT EXISTS(select 1
			from sysreferences sr, sysobjects so, sysobjects so2, sysconstraints sc
			where sc.constid  *= sr.constid and
				  sc.constid = so.id and 
				  sc.id = so2.id 
			and so2.name = 'p_Objective_Result_Qualifier'
			and so.name = 'FK_p_Objective_Result_Qua2__13')
	ALTER TABLE dbo.p_Objective_Result_Qualifier ADD 
		CONSTRAINT FK_p_Objective_Result_Qua2__13 FOREIGN KEY 
		(
		cpr_id,
		treatment_id,
		observation_id,
		location,
		result_sequence
		) REFERENCES dbo.p_Objective_Result (
		cpr_id,
		treatment_id,
		observation_id,
		location,
		result_sequence
		)
GO