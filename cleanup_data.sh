#!/bin/bash

# Prompt the user for the directory containing text files
read -p "Enter the directory containing text files: " input_dir

# Validate the input directory
if [[ ! -d "$input_dir" ]]; then
    echo "Error: Directory '$input_dir' does not exist."
    exit 1
fi

# Create the output directory
output_dir="cleaned_data"
mkdir -p "$output_dir"

# Log file for processed files
log_file="cleanup_log.txt"
> "$log_file" # Clear the log file if it exists

# Process each text file in the input directory
for file in "$input_dir"/*.txt; do
    if [[ -f "$file" ]]; then
        # Get the base name of the file (without the directory path)
        base_name=$(basename "$file")
        
        # Define the output file path
        output_file="$output_dir/$base_name"
        
        # Process the file:
        # - Remove blank lines
        # - Convert text to lowercase
        # - Remove duplicate lines
        awk 'NF' "$file" | tr '[:upper:]' '[:lower:]' | awk '!seen[$0]++' > "$output_file"
        
        # Log the processed file
        echo "$base_name" >> "$log_file"
    fi
done

echo "Processing complete. Cleaned files are in '$output_dir', and logs are saved in '$log_file'."
