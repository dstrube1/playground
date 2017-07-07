SELECT 'searchignite/maindb',name FROM sysobjects
 WHERE id IN ( SELECT id FROM syscolumns WHERE name like '%Referral%' ) Order by name