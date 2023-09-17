use [LibraryDatabase];
-- Create the Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title NVARCHAR(100),
    Author NVARCHAR(50),
    ISBN VARCHAR(50),
    PublishedDate DATE,
    Genre NVARCHAR(50),
    ShelfLocation NVARCHAR(50),
    CurrentStatus NVARCHAR(50) CHECK (CurrentStatus IN ('Available', 'Borrowed'))
);
-- Create the Borrowers table
CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(255),
    DateOfBirth DATE,
    MembershipDate DATE
);
-- Create the Loans table
CREATE TABLE Loans (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    BorrowerID INT,
    DateBorrowed DATE,
    DueDate DATE,
    DateReturned DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);