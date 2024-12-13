#!/bin/bash

# Function to validate if a file exists
validate_file() {
    if [[ ! -f "$1" ]]; then
        echo "Error: File '$1' does not exist."
        exit 1
    fi
}

# Function to check if a column is numeric
is_numeric_column() {
    local file="$1"
    local col="$2"
    awk -F, -v col="$col" 'NR>1 {if ($col !~ /^[0-9]+(\.[0-9]+)?$/) exit 1}' "$file"
}

# Function to find numeric columns
find_numeric_columns() {
    local file="$1"
    local headers=$(head -n 1 "$file" | tr ',' '\n')
    local numeric_cols=()
    local i=1

    while IFS=',' read -r header; do
        if is_numeric_column "$file" "$i"; then
            numeric_cols+=("$i:$header")
        fi
        ((i++))
    done <<< "$headers"

    echo "${numeric_cols[@]}"
}

# Function to calculate column average
calculate_average() {
    local file="$1"
    local column="$2"
    awk -F, -v col="$column" 'NR>1 {sum+=$col; count++} END {print sum/count}' "$file"
}

# Function to email report (optional)
email_report() {
    if [[ -n "$1" ]]; then
        echo "Emailing report to $1"
        mail -s "CSV Report" "$1" < report.txt
    fi
}

# Prompt for CSV file
read -p "Enter the CSV file name: " csv_file
validate_file "$csv_file"

# Find numeric columns
numeric_columns=($(find_numeric_columns "$csv_file"))

# Generate comprehensive report
{
    echo "Comprehensive CSV Report for $csv_file"
    echo "-------------------------------------"
    
    # Record count
    record_count=$(awk -F, 'END {print NR-1}' "$csv_file")
    echo "Total Records: $record_count"
    
    # Analyze each numeric column
    for col_info in "${numeric_columns[@]}"; do
        IFS=':' read -r column_num column_name <<< "$col_info"
        
        echo -e "\nColumn Analysis: $column_name"
        
        # Average
        average=$(calculate_average "$csv_file" "$column_num")
        echo "Average: $average"
        
        # Max and Min
        max_value=$(awk -F, -v col="$column_num" 'NR>1 {max = (NR==2 || $col > max) ? $col : max} END {print max}' "$csv_file")
        min_value=$(awk -F, -v col="$column_num" 'NR>1 {min = (NR==2 || $col < min) ? $col : min} END {print min}' "$csv_file")
        echo "Maximum: $max_value"
        echo "Minimum: $min_value"
    done
} > report.txt

echo "Report generated in report.txt"