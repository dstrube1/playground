
-- Add preferences for Authentication System
DELETE FROM c_Preference
WHERE preference_type = 'SYSTEM'
AND preference_id = 'Authentication System'
GO

INSERT INTO c_Preference (
	preference_type,
	preference_id,
	description,
	param_class,
	global_flag,
	office_flag,
	computer_flag,
	specialty_flag,
	user_flag,
	help,
	encrypted,
	query)
VALUES (
	'SYSTEM',
	'Authentication System',
	'Authentication System',
	'u_param_popup_single',
	'Y',
	'N',
	'N',
	'N',
	'N',
	'Select "PIN" for the legacy Personal Identification Number authentication.  Select "JMJ Secure" for the JMJ username/password authentication.  Default is "PIN".',
	'N',
	'SELECT domain_item,domain_item FROM c_domain WHERE domain_id = ''Authentication System'''
	)
GO

-- Add c_Domain records for preference
DELETE FROM c_Domain
WHERE domain_id = 'Authentication System'
GO

INSERT INTO c_Domain (
	domain_id,
	domain_sequence,
	domain_item)
VALUES (
	'Authentication System',
	1,
	'PIN')
GO

INSERT INTO c_Domain (
	domain_id,
	domain_sequence,
	domain_item)
VALUES (
	'Authentication System',
	2,
	'JMJ Secure')
GO


----------------------------------------------------------
-- Create the JMJ Security Manager component
----------------------------------------------------------

DELETE FROM c_Component_Registry
WHERE component_id = 'AUTH_JMJ'
GO

INSERT INTO c_Component_Registry (
	component_id,
	component_type,
	component,
	description,
	component_class,
	id,
	component_location,
	component_data)
VALUES (
	'AUTH_JMJ',
	'Authentication',
	'Authentication',
	'JMJ Secure Authentication System',
	'u_component_security_jmj_secure',
	'{C13815A9-FAF0-472A-BB0E-40ACEB7E1088}',
	'JMJSecurityManager, Version=1.0.0.2, Culture=neutral, PublicKeyToken=e349e2da3a3c5167',
	'JMJSecurityManager.JMJSecurityManager')
GO

