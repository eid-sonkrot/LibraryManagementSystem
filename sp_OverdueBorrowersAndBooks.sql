CREATE PROCEDURE sp_OverdueBorrowersAndBooks
AS
BEGIN
    CREATE TABLE #TempOverdueBorrowers (
        BorrowerID INT PRIMARY KEY
    );
    INSERT INTO #TempOverdueBorrowers (BorrowerID)
    SELECT DISTINCT L.BorrowerID
    FROM Loans AS L
    WHERE L.DueDate < GETDATE();
    SELECT
        TB.BorrowerID,
        B.Title AS BookTitle,
        B.Author AS BookAuthor,
        L.DateBorrowed AS DateBorrowed,
        L.DueDate AS DueDate
    FROM #TempOverdueBorrowers AS TB
    JOIN Loans AS L ON TB.BorrowerID = L.BorrowerID
    JOIN Books AS B ON L.BookID = B.BookID;
    DROP TABLE #TempOverdueBorrowers;
END;
