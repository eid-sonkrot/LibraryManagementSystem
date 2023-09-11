IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.AuditLog') AND type = 'U')
BEGIN
    CREATE TABLE AuditLog (
        LogID INT IDENTITY(1, 1) PRIMARY KEY,
        BookID INT,
        StatusChange NVARCHAR(50),
        ChangeDate DATETIME
    );
END
GO
CREATE TRIGGER tr_BookStatusChange
ON Books
AFTER UPDATE
AS
BEGIN
    DECLARE @BookID INT;
    DECLARE @OldStatus NVARCHAR(50);
    DECLARE @NewStatus NVARCHAR(50);

    SELECT @BookID = i.BookID,
           @OldStatus = d.CurrentStatus,
           @NewStatus = i.CurrentStatus
    FROM INSERTED i
    INNER JOIN DELETED d ON i.BookID = d.BookID;
    IF (@OldStatus <> @NewStatus) AND
       ((@OldStatus = 'Available' AND @NewStatus = 'Borrowed') OR
        (@OldStatus = 'Borrowed' AND @NewStatus = 'Available'))
    BEGIN
        INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
        VALUES (@BookID, @NewStatus, GETDATE());
    END
END;