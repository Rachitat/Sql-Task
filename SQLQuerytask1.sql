-- Create Database
CREATE DATABASE LibraryDB;
GO
USE LibraryDB;
GO

-- Create Authors table
CREATE TABLE Authors (
  author_id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  country NVARCHAR(50)
);

-- Create Books table
CREATE TABLE Books (
  book_id INT IDENTITY(1,1) PRIMARY KEY,
  title NVARCHAR(200) NOT NULL,
  genre NVARCHAR(50),
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Create Members table
CREATE TABLE Members (
  member_id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  email NVARCHAR(100) UNIQUE,
  phone NVARCHAR(15)
);

-- Create Loans table
CREATE TABLE Loans (
  loan_id INT IDENTITY(1,1) PRIMARY KEY,
  book_id INT,
  member_id INT,
  loan_date DATE,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES Books(book_id),
  FOREIGN KEY (member_id) REFERENCES Members(member_id)
);
