

USE SIAccess

SELECT 'A' AS TableAB, COUNT(1) AS RCount FROM dbo.ClickTrackingRaw_A
UNION
SELECT 'B' AS TableAB, COUNT(1) AS RCount FROM dbo.ClickTrackingRaw_B



SELECT 'A' AS TableAB, COUNT(1) AS RCount FROM dbo.TransactionTrackingRaw_A
UNION
SELECT 'B' AS TableAB, COUNT(1) AS RCount FROM dbo.TransactionTrackingRaw_B



SELECT 'A' AS TableAB, COUNT(1) AS RCount FROM dbo.NatureSearchClickTrackingRaw_A
UNION
SELECT 'B' AS TableAB, COUNT(1) AS RCount FROM dbo.NatureSearchClickTrackingRaw_B


SELECT 'A' AS TableAB, COUNT(1) AS RCount FROM dbo.DisplayClickTrackingRaw_A
UNION
SELECT 'B' AS TableAB, COUNT(1) AS RCount FROM dbo.DisplayClickTrackingRaw_B

