


 WITH ClientsTree
 AS
 (
   SELECT c.ClientID,C.ClientName,c.ParentClientID,
       0 AS Level
   FROM  Clients AS c
   WHERE ClientID = 6048
   UNION ALL
 -- Recursive
    SELECT c.ClientID,C.ClientName,c.ParentClientID,
       LEVEL + 1
   FROM  Clients AS c
   INNER JOIN ClientsTree AS d
       ON c.ParentClientID = d.clientID
    WHERE Statusflag = 1
 )
 
 
 SELECT DISTINCT *
 FROM  ClientsTree ct
WHERE NOT EXISTS(SELECT 1 FROM ClientSearchEngineMapping WHERE ClientID = ct.ClientID AND Statusflag = 1)


