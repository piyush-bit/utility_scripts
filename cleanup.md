# Bash Script Explanation

This script processes text files in a directory by removing blank lines, converting text to lowercase, and removing duplicate lines. The cleaned files are saved in a new directory, and a log of processed files is maintained.

## Line-by-Line Breakdown

1. `#!/bin/bash`  
   Specifies that the script uses the Bash shell.

2. `read -p "Enter the directory containing text files: " input_dir`  
   Prompts the user to input the directory path and stores it in `input_dir`.

3. `if [[ ! -d "$input_dir" ]]; then`  
   Checks if the directory does not exist.

4. `    echo "Error: Directory '$input_dir' does not exist."`  
   Prints an error message if the directory is invalid.

5. `    exit 1`  
   Exits the script with an error code.

6. `fi`  
   Ends the directory validation block.

7. `output_dir="cleaned_data"`  
   Defines the output directory for cleaned files.

8. `mkdir -p "$output_dir"`  
   Creates the output directory if it doesn't exist.

9. `log_file="cleanup_log.txt"`  
   Defines the log file name.

10. `> "$log_file"`  
    Clears any existing content in the log file.

11. `for file in "$input_dir"/*.txt; do`  
    Loops through each `.txt` file in the input directory.

12. `    if [[ -f "$file" ]]; then`  
    Ensures the current item is a file.

13. `        base_name=$(basename "$file")`  
    Extracts the base name of the file.

14. `        output_file="$output_dir/$base_name"`  
    Constructs the path for the cleaned file.

15. `        awk 'NF' "$file" | tr '[:upper:]' '[:lower:]' | awk '!seen[$0]++' > "$output_file"`  
    Processes the file to remove blank lines, convert text to lowercase, and remove duplicate lines, saving the result in the output directory.

16. `        echo "$base_name" >> "$log_file"`  
    Logs the processed file name.

17. `    fi`  
    Ends the file check block.

18. `done`  
    Ends the loop.

19. `echo "Processing complete. Cleaned files are in '$output_dir', and logs are saved in '$log_file'."`  
    Displays a message indicating completion and the locations of the output files and logs.
