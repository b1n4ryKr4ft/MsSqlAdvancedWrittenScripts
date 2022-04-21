DECLARE @storedProcsDumpTBL TABLE([SP_DUMP_TEXT] nVARCHAR(500))
DECLARE @firstValue AS VARCHAR(20)
DECLARE @prefix AS VARCHAR(20)
DECLARE @storedProcFullName AS VARCHAR(100)
DECLARE @storedProcNameTBL AS VARCHAR(100)

DECLARE hammerCursor CURSOR FOR
SELECT name FROM sys.procedures
ORDER BY 1

OPEN hammerCursor

FETCH NEXT FROM hammerCursor INTO @storedProcNameTBL
WHILE @@FETCH_STATUS = 0
BEGIN

    -- PRINT(@storedProcNameTBL)
    -- SET @firstValue = SUBSTRING(@storedProcNameTBL, 0, CHARINDEX('_', @storedProcNameTBL))

    -- IF(isnumeric(@firstValue) = 1)
    --     SET @prefix = 'rpt'
    -- ELSE
    --     SET @prefix ='dbo'

    EXEC xp_sprintf @storedProcFullName OUTPUT, N'dbo.%s',@storedProcNameTBL

    INSERT INTO @storedProcsDumpTBL([SP_DUMP_TEXT]) 
    EXEC sp_helptext @storedProcFullName

    FETCH NEXT FROM hammerCursor INTO @storedProcNameTBL
END

CLOSE hammerCursor
DEALLOCATE hammerCursor

SELECT * FROM @storedProcsDumpTBL