# Bash Script Explanation

This script provides a menu-driven interface for performing two operations:
1. Backing up a directory.
2. Restoring data from a backup.  
It includes proper error handling and logging.

## Line-by-Line Breakdown

### 1. `#!/bin/bash`
   Specifies that the script uses the Bash shell.

### 2-5. `display_menu()`  
   Defines a function to display the main menu with three options:
   - Backup a directory.
   - Restore data from a backup.
   - Exit.

### 6-24. `backup_directory()`  
   Defines a function for backing up a directory.
   - Prompts the user for a directory path.
   - Validates if the directory exists (`[ ! -d "$dir_to_backup" ]`).
   - Creates a timestamped tarball (`backup_<timestamp>.tar.gz`) for the specified directory.
   - Logs the backup operation in `backup_log.txt` on success or displays an error if the process fails.

### 25-47. `restore_backup()`  
   Defines a function for restoring data from a backup.
   - Lists all available backup files (`ls backup_*.tar.gz`).
   - Prompts the user to input the name of the backup file and the target restore directory.
   - Validates both the backup file and restore location.
   - Extracts the contents of the tarball into the specified location and logs success or failure.

### 48-66. `while true`  
   Implements a continuous loop to display the menu and handle user choices.
   - Reads the user's input (`read -p "Enter your choice: " choice`).
   - Executes the corresponding function based on the choice:
     - `1` calls `backup_directory`.
     - `2` calls `restore_backup`.
     - `3` exits the script.
   - Prints an error message for invalid choices.
