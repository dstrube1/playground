-- Check user's PermissionID by RoleID in Legacy system
USE Searchignite
/*
truncate table AccessRoleUserClientMap
insert into AccessRoleUserClientMap
select * from AccessRoleUserClientMap_backup
*/

DECLARE @UserID INT,
		@ClientID INT,
		@ExplicitDeny VARCHAR(20),
		@RoleID INT =3,
		@Permissionid INT =39,
		@debug BIT = 1
		
--Seperate Table to INSERT EXEC		
CREATE TABLE #Get_Permission
(
	Permissionid INT   
)

CREATE TABLE #Check_Permission
(
	UserID INT,
	ClientID INT,
	Permissionid INT,
	RoleID_Legacy INT,
	ExplicitDeny_Legacy VARCHAR(20)   
)		
DECLARE Get_PermissionID_cursor CURSOR FOR
SELECT DISTINCT UserID,ClientID FROM Users_Clients_Role 

OPEN Get_PermissionID_cursor   
FETCH NEXT FROM Get_PermissionID_cursor INTO @UserID, @ClientID 

WHILE @@FETCH_STATUS = 0   
BEGIN 

	INSERT INTO #Get_Permission
		EXEC SI_SP_GetPermissions_ByUserClient @UserID , @ClientID

	INSERT INTO #Check_Permission ( UserID, ClientID, Permissionid)
		VALUES(@UserID, @ClientID,(SELECT * FROM #Get_Permission WHERE Permissionid = @Permissionid))
		
	UPDATE #Check_Permission
		SET RoleID_Legacy =(
			SELECT RoleID FROM AccessRoleUserClientMap AS AR
			WHERE AR.UserID = @UserID AND AR.ClientID = @ClientID AND AR.RoleID =@RoleID)
		WHERE ClientID=@ClientID AND UserID=@UserID
		
		IF (SELECT ExplicitDeny  FROM AccessRoleUserClientMap AS AR WHERE AR.UserID = @UserID AND AR.ClientID = @ClientID AND AR.RoleID =@RoleID) = 1
		BEGIN
			UPDATE #Check_Permission
				SET ExplicitDeny_Legacy  = 'True'
			WHERE ClientID=@ClientID AND UserID=@UserID AND Permissionid = @Permissionid
		END	
		
		ELSE 
		BEGIN
			UPDATE #Check_Permission
				SET ExplicitDeny_Legacy  = 'False'
			WHERE ClientID=@ClientID AND UserID=@UserID AND Permissionid = @Permissionid
		END
		
	TRUNCATE TABLE #Get_Permission

	FETCH NEXT FROM Get_PermissionID_cursor INTO @UserID, @ClientID
END   

IF @debug =1
BEGIN 
	SELECT * FROM #Check_Permission
	--How many are not setup properly
	SELECT COUNT(1) AS INCORRECT FROM #Check_Permission WHERE (RoleID_Legacy <> @RoleID OR RoleID_Legacy IS NULL AND Permissionid=@Permissionid) OR (Permissionid <> @Permissionid OR Permissionid IS NULL AND RoleID_Legacy = @RoleID)
	SELECT COUNT(1) AS CASE1 FROM #Check_Permission WHERE  Permissionid = @Permissionid AND RoleID_Legacy IS NULL OR RoleID_Legacy <> 3
	SELECT COUNT(1) AS CASE2 FROM #Check_Permission WHERE  (Permissionid IS NULL OR Permissionid <> @Permissionid) AND RoleID_Legacy = @RoleID
	
END

ELSE
BEGIN
	--Case 1: PermissionID is @PermissionID and RoleID is incorrect, Need to add Role
	WHILE (SELECT COUNT(1) FROM #Check_Permission WHERE  Permissionid = @Permissionid AND RoleID_Legacy IS NULL OR RoleID_Legacy <> 3) > 0
	BEGIN
		SELECT TOP 1 @ClientID=ClientID,  @UserID=UserID, @ExplicitDeny=ExplicitDeny_Legacy  FROM #Check_Permission WHERE  Permissionid = @Permissionid AND RoleID_Legacy IS NULL OR RoleID_Legacy <> 3
		--SELECT @ClientID,@UserID,@ExplicitDeny
		exec SI_SP_Access_Role_SaveClientUserMapping @RoleID, @ClientID, @UserID, @ExplicitDeny
		exec SI_SP_Access_Role_SaveClientUserMapping 3, 3340, 3881, 'False'
		DELETE FROM #Check_Permission
		WHERE ClientID = @ClientID AND UserID = @UserID AND Permissionid = @Permissionid  
	END	  
	
	--Case 2: RoleID = @RoleID and PermissionId is incorrect, Need to delete Role
	--WHILE (SELECT COUNT(1) FROM #Check_Permission WHERE  (Permissionid IS NULL OR Permissionid <> @Permissionid) AND RoleID_Legacy = @RoleID) > 0
	--BEGIN
	--	SELECT TOP 1  @UserID=UserID, @ClientID=ClientID FROM #Check_Permission WHERE  (Permissionid IS NULL OR Permissionid <> @Permissionid) AND RoleID_Legacy = @RoleID
	--	SELECT @UserID, @ClientID
	--	--exec SI_SP_Access_Role_SaveClientUserMapping @RoleID, @ClientID, @UserID, @ExplicitDeny
	--	DELETE FROM #Check_Permission
	--	WHERE ClientID = @ClientID AND UserID = @UserID AND RoleID_Legacy = @RoleID
	--END
	
END

-- Cleanup
DROP TABLE #Check_Permission
DROP TABLE #Get_Permission
CLOSE Get_PermissionID_cursor   
DEALLOCATE Get_PermissionID_cursor




