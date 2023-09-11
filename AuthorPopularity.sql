SELECT
    B.Author AS Author,
    COUNT(L.LoanID) AS BorrowingFrequency
FROM
    Books AS B
LEFT JOIN
    Loans AS L ON B.BookID = L.BookID
GROUP BY
    B.Author
ORDER BY
    BorrowingFrequency DESC;