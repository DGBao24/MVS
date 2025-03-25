-- This script updates the Seat table to remove the Status column
-- since we're now deriving seat status from tickets

-- First, find and drop any constraints on the Status column
DECLARE @constraintName NVARCHAR(128)

-- Find check constraints that might be related to Status column
SELECT TOP 1 @constraintName = cc.name
FROM sys.check_constraints cc
JOIN sys.columns c ON cc.parent_object_id = c.object_id
WHERE cc.parent_object_id = OBJECT_ID('Seat')
AND c.name = 'Status'
AND cc.parent_column_id = c.column_id

-- Drop the constraint if it exists
IF @constraintName IS NOT NULL
BEGIN
    DECLARE @sql NVARCHAR(200) = N'ALTER TABLE [dbo].[Seat] DROP CONSTRAINT ' + QUOTENAME(@constraintName)
    EXEC sp_executesql @sql
    PRINT 'Dropped constraint: ' + @constraintName
END
ELSE
BEGIN
    PRINT 'No constraint found for Status column'
END

-- Then remove the Status column
IF EXISTS (
    SELECT * 
    FROM sys.columns 
    WHERE object_id = OBJECT_ID('Seat') 
    AND name = 'Status'
)
BEGIN
    ALTER TABLE [dbo].[Seat] DROP COLUMN [Status];
    PRINT 'Dropped Status column from Seat table'
END
ELSE
BEGIN
    PRINT 'Status column does not exist'
END

-- Add back the Status column with default 'Available'
ALTER TABLE [dbo].[Seat] ADD [Status] [nvarchar](50) DEFAULT 'Available';
PRINT 'Added Status column with default value Available'

-- Add a comment to explain this is now a derived value
BEGIN TRY
    EXEC sp_addextendedproperty 
       @name = N'MS_Description', 
       @value = N'This is a derived value from tickets, not an actual stored state', 
       @level0type = N'SCHEMA', @level0name = N'dbo', 
       @level1type = N'TABLE',  @level1name = N'Seat', 
       @level2type = N'COLUMN', @level2name = N'Status';
    PRINT 'Added description to Status column'
END TRY
BEGIN CATCH
    PRINT 'Could not add extended property: ' + ERROR_MESSAGE()
END CATCH

PRINT 'Script completed successfully' 