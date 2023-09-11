use LibraryDatabase;
-- Generate and insert loan records for valid combinations of Borrowers and Books
INSERT INTO Loans (BookID, BorrowerID, DateBorrowed, DueDate,DateReturned)
SELECT DISTINCT
    B.BookID AS BookID,
    BR.BorrowerID AS BorrowerID,
    DATEADD(day, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()) AS DateBorrowed,
    DATEADD(day, ABS(CHECKSUM(NEWID())) % 21 + 7, GETDATE()) AS DueDate,
	DATEADD(day, ABS(CHECKSUM(NEWID())) % 21 + 7, GETDATE()) AS DateReturned
FROM
    (
        SELECT DISTINCT
            BookID
        FROM
            Books
        WHERE
            CurrentStatus = 'Borrowed'
    ) AS B
JOIN
    (
        SELECT 
            BorrowerID
        FROM
            Borrowers
      
    ) AS BR
ON BR.BorrowerID=[B].[BookID];