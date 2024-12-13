import os
import sys

def generate_folder_structure(start_path, output_file="folder_structure.txt", ignore_patterns=None):
    """
    Generate a text representation of folder structure, optionally ignoring certain patterns.
    
    Args:
        start_path (str): Root directory to start scanning
        output_file (str): Output file name to save the structure
        ignore_patterns (list): List of patterns to ignore (e.g., ['.git', '__pycache__'])
    """
    if ignore_patterns is None:
        ignore_patterns = ['.git', '__pycache__', '.vs', '.vscode', 'node_modules']
    
    def should_ignore(path):
        return any(pattern in path for pattern in ignore_patterns)
    
    def get_structure(path, indent=""):
        if should_ignore(path):
            return ""
        
        structure = []
        try:
            # Add current directory name
            dirname = os.path.basename(path)
            if dirname:  # Skip for root directory
                structure.append(f"{indent}📁 {dirname}/")
            
            # List and sort directory contents
            items = os.listdir(path)
            items.sort()
            
            # Process directories first, then files
            dirs = [item for item in items if os.path.isdir(os.path.join(path, item))]
            files = [item for item in items if os.path.isfile(os.path.join(path, item))]
            
            # Add directories
            for item in dirs:
                full_path = os.path.join(path, item)
                if not should_ignore(full_path):
                    structure.append(get_structure(full_path, indent + "  "))
            
            # Add files
            for item in files:
                if not should_ignore(item):
                    structure.append(f"{indent}  📄 {item}")
                    
        except PermissionError:
            structure.append(f"{indent}  ⚠️ Permission denied")
        
        return "\n".join(filter(None, structure))
    
    # Generate the structure
    structure = get_structure(start_path)
    
    # Save to file
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(f"SDL Project Structure\n{'=' * 20}\n\n")
        f.write(structure)
    
    return structure

# Example usage
if __name__ == "__main__":
    print("SDL Project Structure")
    print(len(sys.argv))
    # Get path from command line
    if len(sys.argv) >1:
        #get path from the command line 
        input_path = sys.argv[1]

        # convert to absolute path
        input_path = os.path.abspath(input_path)

        # generate the structure
        structure = generate_folder_structure(input_path)
        print(structure)
    else:
        print("Usage: python filestructure.py <path>")
