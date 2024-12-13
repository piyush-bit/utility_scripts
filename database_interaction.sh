#!/bin/bash

# SQLite database file
DB_NAME="example.db" # Update this to your SQLite database file path

# Check if the database file exists
if [[ ! -f "$DB_NAME" ]]; then
    echo "Database file '$DB_NAME' does not exist."
    echo "To create a new SQLite database, use the following command:"
    echo "  sqlite3 $DB_NAME"
    echo "After creating the database, ensure you define the required tables using SQL commands."
    echo "For example:"
    echo "  CREATE TABLE example_table (id INTEGER PRIMARY KEY, name TEXT, age INTEGER);"
    exit 1
fi

# Function to execute SQLite commands
run_sqlite_command() {
    echo "$1" | sqlite3 "$DB_NAME"
}

# Main menu
while true; do
    echo "Choose an option:"
    echo "1. Display all records in a specified table"
    echo "2. Insert a new record into a specified table"
    echo "3. Delete a record based on a specified condition"
    echo "4. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            read -p "Enter the table name: " table
            query="SELECT * FROM $table;"
            echo "Records in $table:"
            run_sqlite_command "$query"
            ;;
        2)
            read -p "Enter the table name: " table
            read -p "Enter the field names (comma-separated): " fields
            read -p "Enter the values (comma-separated, use single quotes for text): " values
            query="INSERT INTO $table ($fields) VALUES ($values);"
            run_sqlite_command "$query"
            echo "Record inserted into $table."
            ;;
        3)
            read -p "Enter the table name: " table
            read -p "Enter the condition for deletion (e.g., id=5): " condition
            query="DELETE FROM $table WHERE $condition;"
            run_sqlite_command "$query"
            echo "Record(s) deleted from $table where $condition."
            ;;
        4)
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
