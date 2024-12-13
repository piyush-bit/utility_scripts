# Bash Script Explanation

This script analyzes a CSV file to generate a comprehensive report of its numeric columns, including metrics like averages, maximums, and minimums. The generated report is saved to `report.txt`.

## Line-by-Line Breakdown

### 1. `#!/bin/bash`
   Specifies that the script uses the Bash shell.

### 2-6. `validate_file()`  
   - Checks if the provided file exists (`[[ ! -f "$1" ]]`).
   - If the file does not exist, prints an error message and exits the script.

### 7-12. `is_numeric_column()`  
   - Verifies whether a specified column in a CSV file contains only numeric data.
   - Uses `awk` with a field separator (`-F,`) to check if all non-header rows in the column match the numeric pattern (`^[0-9]+(\.[0-9]+)?$`).

### 13-26. `find_numeric_columns()`  
   - Identifies all numeric columns in the CSV file:
     - Reads the header row.
     - Iterates through each column using a loop.
     - Calls `is_numeric_column()` to determine if the column is numeric.
     - If numeric, appends the column index and name (`i:header`) to the list.
   - Outputs the numeric column information as an array.

### 27-30. `calculate_average()`  
   - Calculates the average of a numeric column using `awk`.
   - Sums all values in the specified column and divides by the number of records (`sum/count`).

### 31-36. `email_report()`  
   - (Optional) Emails the generated report to a specified email address using the `mail` command.
   - Prints a message if an email address is provided.

### 37-39. CSV File Prompt and Validation  
   - Prompts the user to enter the name of the CSV file.
   - Validates the file using `validate_file()`.

### 40-42. Find Numeric Columns  
   - Calls `find_numeric_columns()` to identify numeric columns in the CSV file.
   - Stores the results in the `numeric_columns` array.

### 43-59. Generate Report  
   - Redirects the report output to `report.txt`.
   - Prints a header with the CSV file name.
   - Counts the total number of records (`awk` calculates `NR-1` to exclude the header row).
   - Loops through each numeric column:
     - Splits `column_num:column_name` to extract the column index and name.
     - Calculates metrics (average, maximum, minimum) for each column using:
       - `calculate_average()` for the average.
       - Inline `awk` commands for maximum and minimum values.
   - Outputs these metrics to the report.

### 60. Output Completion Message  
   - Notifies the user that the report has been saved to `report.txt`.
