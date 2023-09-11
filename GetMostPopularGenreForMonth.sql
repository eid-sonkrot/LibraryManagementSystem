CREATE FUNCTION GetMostPopularGenreForMonth(@Month INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Genre NVARCHAR(50);
    WITH LoanedGenres AS (
        SELECT
            B.Genre,
            COUNT(*) AS GenreCount,
            RANK() OVER (ORDER BY COUNT(*) DESC) AS GenreRank
        FROM
            Loans AS L
        JOIN
            Books AS B ON L.BookID = B.BookID
        WHERE
            MONTH(L.DateBorrowed) = @Month
        GROUP BY
            B.Genre
    )
    
    SELECT TOP 1
        @Genre = Genre
    FROM
        LoanedGenres
    WHERE
        GenreRank = 1;

    RETURN @Genre;
END;