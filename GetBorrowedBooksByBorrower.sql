CREATE FUNCTION GetBorrowedBooksByBorrower(@BorrowerID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT B.BookID,B.Title,B.Author,B.ISBN,B.PublishedDate,B.Genre,B.ShelfLocation,B.CurrentStatus
    FROM Loans AS L
    JOIN Books AS B ON L.BookID = B.BookID
    WHERE L.BorrowerID = @BorrowerID
);