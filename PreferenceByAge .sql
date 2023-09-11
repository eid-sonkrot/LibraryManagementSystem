SELECT
    PreferredGenre,
	AgeGroup,
    COUNT(*) AS BorrowerCount
FROM
    (
        SELECT
            CASE
                WHEN DATEDIFF(YEAR, B.DateOfBirth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
                WHEN DATEDIFF(YEAR, B.DateOfBirth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
                WHEN DATEDIFF(YEAR, B.DateOfBirth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
                ELSE 'more than 30'
            END AS AgeGroup,
            Bo.Genre AS PreferredGenre
        FROM
            Borrowers AS B
        JOIN
            Loans AS L ON B.BorrowerID = L.BorrowerID
        JOIN
            Books AS Bo ON L.BookID = Bo.BookID
    ) AS AgeGenre
GROUP BY
    AgeGroup, 
    PreferredGenre
HAVING
    COUNT(*) > 0
ORDER BY
    AgeGroup,
    BorrowerCount DESC;
