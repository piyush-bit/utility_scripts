# Bash Script Explanation

This script interacts with an SQLite database through a menu-driven interface. It allows users to display records, insert new records, and delete records from specified tables. The database file is checked at startup to ensure it exists.

## Line-by-Line Breakdown

### 1. `#!/bin/bash`
   Specifies that the script uses the Bash shell.

### 2. `DB_NAME="example.db"`
   Sets the SQLite database file name. Update this to point to your SQLite database file.

### 3-12. Database File Check  
   - Verifies if the database file exists (`[[ ! -f "$DB_NAME" ]]`).
   - If not found, displays instructions for creating a new SQLite database and defining tables using SQL commands.
   - Exits with an error if the database file is missing.

### 13-15. `run_sqlite_command()`  
   Defines a function to execute SQLite commands.
   - Takes a single argument (`$1`) as the SQL query.
   - Pipes the query to the `sqlite3` command using the specified database file.

### 16-40. Main Menu Loop  
   - Implements a continuous loop to display a menu and handle user choices.

#### Option 1: Display All Records  
   - Prompts the user to input the table name.
   - Constructs a SQL query (`SELECT * FROM $table;`) to fetch all records.
   - Executes the query using the `run_sqlite_command` function and displays the results.

#### Option 2: Insert a New Record  
   - Prompts the user to input:
     - The table name.
     - Field names (comma-separated).
     - Values (comma-separated, with single quotes for text).
   - Constructs an `INSERT INTO` SQL query with the provided input.
   - Executes the query to insert the record and confirms success.

#### Option 3: Delete a Record  
   - Prompts the user to input:
     - The table name.
     - A condition for deletion (e.g., `id=5`).
   - Constructs a `DELETE FROM` SQL query with the provided condition.
   - Executes the query to delete the specified record(s) and confirms success.

#### Option 4: Exit  
   - Exits the loop and ends the script.

#### Invalid Input Handling  
   - Displays an error message for invalid menu choices and re-displays the menu.

### 41. `done`
   Marks the end of the menu loop.
