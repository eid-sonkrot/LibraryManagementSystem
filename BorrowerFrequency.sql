WITH BorrowerFrequency AS (
    SELECT
        B.BorrowerID,
        B.FirstName,
        B.LastName,
        B.Email,
        COUNT(L.LoanID) AS BorrowingFrequency,
        RANK() OVER (ORDER BY COUNT(L.LoanID) DESC) AS BorrowingRank
    FROM
        Borrowers AS B
    LEFT JOIN
        Loans AS L ON B.BorrowerID = L.BorrowerID
    GROUP BY
        B.BorrowerID, B.FirstName, B.LastName, B.Email
)
SELECT
    BorrowerID,
    FirstName,
    LastName,
    Email,
    BorrowingFrequency,
    BorrowingRank
FROM
    BorrowerFrequency;
