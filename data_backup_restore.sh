#!/bin/bash

# Function to display the menu
display_menu() {
  echo "Please choose an option:"
  echo "1. Backup a directory"
  echo "2. Restore data from a backup"
  echo "3. Exit"
}

# Function to backup a directory
backup_directory() {
  echo "Enter the path of the directory to back up:"
  read dir_to_backup

  if [ ! -d "$dir_to_backup" ]; then
    echo "Error: Directory does not exist."
    return
  fi

  timestamp=$(date +%Y%m%d_%H%M%S)
  backup_file="backup_${timestamp}.tar.gz"
  tar -czf "$backup_file" "$dir_to_backup"
  
  if [ $? -eq 0 ]; then
    echo "Backup successful: $backup_file"
    echo "$(date) - Backup created: $backup_file for directory: $dir_to_backup" >> backup_log.txt
  else
    echo "Error: Backup failed."
  fi
}

# Function to restore a backup
restore_backup() {
  echo "Available backups:"
  ls backup_*.tar.gz 2>/dev/null
  if [ $? -ne 0 ]; then
    echo "No backup files found."
    return
  fi

  echo "Enter the name of the backup file to restore:"
  read backup_file

  if [ ! -f "$backup_file" ]; then
    echo "Error: Backup file does not exist."
    return
  fi

  echo "Enter the directory where you want to restore the backup:"
  read restore_location

  if [ ! -d "$restore_location" ]; then
    echo "Error: Restore location does not exist."
    return
  fi

  tar -xzf "$backup_file" -C "$restore_location"

  if [ $? -eq 0 ]; then
    echo "Restore successful to $restore_location"
  else
    echo "Error: Restore failed."
  fi
}

# Main program loop
while true; do
  display_menu
  read -p "Enter your choice: " choice

  case $choice in
    1)
      backup_directory
      ;;
    2)
      restore_backup
      ;;
    3)
      echo "Exiting."
      exit 0
      ;;
    *)
      echo "Invalid option. Please try again."
      ;;
  esac
done
