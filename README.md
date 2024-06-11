# Library Management System

This project demonstrates my ability to link Python with MySQL to manage a library database. It includes SQL queries to perform various operations such as checking available books, adding new books, generating reports, and more.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [SQL Queries](#sql-queries)
- [License](#license)

## Introduction
The Library Management System is designed to perform various operations related to managing a library's book inventory and loans. The project showcases the integration of MySQL with Python to execute SQL queries and handle database operations efficiently.

## Features
- Check the number of available copies of a book.
- Add new books to the library.
- Generate reports of books due back on a specific date with patron contact information.
- Return books to the library.
- Generate a report of patrons who have checked out the fewest books.
- Create a list of books from a specific decade that are currently available.
- Show statistics of books published each year.
- Display the 5 most popular books to check out.

## Requirements
- Python 3.x
- MySQL
- mysql-connector-python

## Installation
1. **Clone the repository:**
    \`\`\`bash
    git clone https://github.com/ibrahimsaber1/Lynda-Library-Proejct.git
    cd library-management-system
    \`\`\`

2. **Install the required Python package:**
    \`\`\`bash
    pip install mysql-connector-python
    \`\`\`

3. **Set up the MySQL database:**
    - Create a MySQL database named `library`.
    - Use the provided SQL scripts to create the necessary tables (`books`, `loans`, `patrons`).

## Usage
1. **Connect to the MySQL database:**
    Modify the connection parameters in the Python script to match your MySQL setup:
    \`\`\`python
    conn = mysql.connector.connect(
        host="127.0.0.1",
        username="root",
        password="yourpassword",
        database="library",
        port=3306
    )
    \`\`\`

2. **Run the Python script:**
    \`\`\`python
    import mysql.connector

    conn = mysql.connector.connect(host="127.0.0.1", username="root", password="yourpassword", database="library", port=3306)
    cursor = conn.cursor()

    # Execute queries and operations
    # Example: Find the number of available copies of Dracula
    cursor.execute("""
        SELECT (COUNT(*) - (SELECT COUNT(*)
                            FROM books b 
                            JOIN loans l ON b.BookID = l.BookID
                            WHERE b.Title = 'Dracula' AND l.ReturnedDate IS NULL)) AS available_Dracula_copies
        FROM books
        WHERE Title = 'Dracula';
    """)
    available_Dracula_copies = cursor.fetchall()
    print(f'The available Dracula copies is {available_Dracula_copies[0][0]}')
    \`\`\`

3. **Explore other functionalities:**
    - Add new books.
    - Generate various reports.
    - Return books.

## SQL Queries
The following are the key SQL queries used in this project:

1. **Find the number of available copies of Dracula:**
    \`\`\`sql
    SELECT (COUNT(*) - (SELECT COUNT(*)
                        FROM books b 
                        JOIN loans l ON b.BookID = l.BookID
                        WHERE b.Title = 'Dracula' AND l.ReturnedDate IS NULL)) AS available_Dracula_copies
    FROM books
    WHERE Title = 'Dracula';
    \`\`\`

2. **Add new books to the library:**
    \`\`\`sql
    INSERT INTO books (BookID, Title, Author, Published, Barcode) VALUES 
    (202, 'CSS', 'Hamad', 2023, 1234567898);
    \`\`\`

3. **Check books for due back:**
    \`\`\`sql
    SELECT b.BookID, b.Title, p.FirstName, p.LastName, l.DueDate, l.ReturnedDate
    FROM books b 
    JOIN loans l ON b.BookID = l.BookID
    JOIN patrons p ON p.PatronID = l.PatronID
    WHERE l.DueDate = '2020-07-13';
    \`\`\`

4. **Return books to the library:**
    \`\`\`sql
    SET SQL_SAFE_UPDATES = 0;
    UPDATE loans
    SET ReturnedDate = '2020-07-13'
    WHERE DueDate = '2020-07-13' AND ReturnedDate IS NULL;
    SET SQL_SAFE_UPDATES = 1;
    \`\`\`

5. **Generate a report of patrons who have checked out the fewest books:**
    \`\`\`sql
    SELECT p.FirstName, p.LastName, COUNT(b.BookID) AS book_count
    FROM books b 
    JOIN loans l ON b.BookID = l.BookID
    JOIN patrons p ON p.PatronID = l.PatronID
    GROUP BY p.FirstName, p.LastName
    ORDER BY book_count
    LIMIT 10;
    \`\`\`

6. **Create a list of books from the 1890s that are currently available:**
    \`\`\`sql
    SELECT *
    FROM books b 
    LEFT JOIN loans l ON b.BookID = l.BookID AND l.ReturnedDate IS NULL
    WHERE b.Published BETWEEN 1890 AND 1899 AND l.BookID IS NULL;
    \`\`\`

7. **Show statistics of books published each year:**
    \`\`\`sql
    SELECT Published, COUNT(DISTINCT Title) AS TotalNumberOfPublishedBooks
    FROM books
    GROUP BY Published
    ORDER BY TotalNumberOfPublishedBooks DESC;
    \`\`\`

8. **Show the 5 most popular books to check out:**
    \`\`\`sql
    SELECT b.Title, COUNT(b.Title) AS TotalTimesOfLoans
    FROM books b
    JOIN loans l ON b.BookID = l.BookID
    GROUP BY b.Title
    ORDER BY TotalTimesOfLoans DESC
    LIMIT 5;
    \`\`\`

## License
This project is licensed under the MIT License - see the [LICENSE](License) file for details.
