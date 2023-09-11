use LibraryDatabase;
WITH BorrowerLoanCounts AS (
    SELECT
        L.BorrowerID,
        COUNT(*) AS BorrowedCount
    FROM
        Loans AS L
    GROUP BY
        L.BorrowerID
    HAVING
        COUNT(*) >= 2
)

SELECT
    B.BorrowerID,
    B.FirstName,
    B.LastName,
    B.Email
FROM
    Borrowers AS B
JOIN
    BorrowerLoanCounts AS BLC ON B.BorrowerID = BLC.BorrowerID;