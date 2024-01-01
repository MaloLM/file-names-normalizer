#!/bin/bash

# List of directory names to ignore
directories_to_ignore=(".git" "sub-to-ignore")

# List of file extensions to ignore
extensions_to_ignore=("DS_Store")

# Function definition: parser()
# PARSING RULES
parser() {
 local name="$1"

 # Replace spaces with underscores
 name=$(replace_char "$name" " " "_")

 # Convert to lowercase
 name=$(echo "$name" | tr "[A-Z]" "[a-z]")

 # Replace # with underscores
 name=$(replace_char "$name" "#" "_")

 # Replace - with underscores
 name=$(replace_char "$name" "-" "_")

 # Delete prefix spaces
 name=${name# }

 # Delete suffix spaces
 name=${name% }

 # Replace spaces with underscores
 # name=$(echo "$name" | sed -r 's/[ ]+/_/g')

 # Remove special characters (like #, $, %, &, etc.)
 # name=$(echo "$name" | sed 's/[^a-zA-Z0-9_.-]//g')

 # Remove multiple underscores (if any)
 # name=$(echo "$name" | sed 's/__\+/_/g')

 # Remove leading and trailing underscores (if any)
 # name=$(echo "$name" | sed 's/^_+|_+$//g')

 # Trim consecutive dashes
 # name=$(echo "$name" | sed 's/-\+/-/g')

 # Remove leading and trailing dashes (if any)
 # name=$(echo "$name" | sed 's/^-+|-+$//g')

 # Remove all numbers from the file name
 # name=$(echo "$name" | sed 's/[0-9]//g')

 # Add current date as a prefix or suffix to the file name
 # Prefix
 # name="$(date +%Y%m%d)_$name"
 # Or, as a suffix
 # name="$name_$(date +%Y%m%d)"

 # Remove all dashes and underscores
 # name=$(echo "$name" | tr -d '_-')

 echo "$name"
}

replace_char() {
    local input="$1"
    local search_char="$2"
    local replace_char="$3"

    # Replace the character
    echo "${input//$search_char/$replace_char}"
}

# Define the path of the temporary file to store file paths
path_file="/tmp/paths.txt"

# Check if a directory argument is provided
if [ -n "$1" ]; then
    # If an argument is provided, use it as the directory
    target_directory="$1"
else
    # If no argument is provided, use the current directory
    target_directory="."
fi

# Choose the appropriate method based on the operating system
case "$(uname -s)" in
   Darwin)
     # For macOS (Darwin), use 'tail -r' to reverse the output of 'find'
     find "$target_directory" | tail -r > $path_file
     ;;

   Linux)
     # For Linux, use 'tac' to reverse the output of 'find'
     find "$target_directory" | tac > $path_file
     ;;

   *)
     # Default case: also use 'tac' for any other OS
     find "$target_directory" | tac > $path_file
     ;;
esac

# Main loop to process each path in the paths file

while IFS="" read -r p || [ -n "$p" ]
do
  
  # Check if the path is a directory
  if [ -d "$p" ]; then
    # Retrieve the directory name without the path
    dir_name=$(basename "$p")
    
    # Check if the directory is not in the ignore list
    if [[ ! " ${directories_to_ignore[@]} " =~ " ${dir_name} " ]]; then
      # Parse and rename the directory
      new_dir_name=$(parser "$dir_name")
      if [[ "$dir_name" != "$new_dir_name" ]]; then
        # Construct new directory path
        new_dir_path="$(dirname "$p")/$new_dir_name"

        # Check if new directory name already exists
        if [ -d "$new_dir_path" ]; then
          new_dir_name="${new_dir_name} other"
          new_dir_name=$(parser "$new_dir_name")
          new_dir_path="$(dirname "$p")/$new_dir_name"
        fi
        # Rename the directory
        mv "$p" "$new_dir_path"
        echo "Renamed directory from '$dir_name' to '$new_dir_name'"
      fi
    fi
  elif [ -f "$p" ]; then
    
    # Check if the file is not in an ignored directory
    ignore_file=false
    # Split the path into directories
    IFS='/' read -ra ADDR <<< "$p"
    for dir_part in "${ADDR[@]}"; do
      # Check each part of the path
      if [[ " ${directories_to_ignore[@]} " =~ " ${dir_part} " ]]; then
        ignore_file=true
        break
      fi
    done
    
    # If the file is not to be ignored
    if [[ "$ignore_file" == false ]]; then

      extension="${p##*.}"
      file_name=$(basename "$p")

      # Check if the file has an extension and if it's not in the ignore list
      if [[ "$file_name" == "$extension" || ! " ${extensions_to_ignore[@]} " =~ " ${extension} " ]]; then
        # Retrieve the base name of the file
        base_name=$(basename "$p" ".$extension")
        
        # Parse and rename the file name (without its extension)  
        new_base_name=$(parser "$base_name")
        if [[ "$base_name" != "$new_base_name" ]]; then
        # Construct new file path
        new_file_path="$(dirname "$p")/$new_base_name.$extension"

        # Check if new file name already exists
        if [ -f "$new_file_path" ]; then
          new_base_name="${new_base_name} other"
          new_base_name=$(parser "$new_base_name")
          new_file_path="$(dirname "$p")/$new_base_name.$extension"
        fi
          # Rename the file
          mv "$p" "$new_file_path"
          echo "Renamed file from '$base_name.$extension' to '$new_base_name.$extension'"
        fi
      fi
    fi
  fi
done < $path_file

# Remove the temporary file after processing
rm $path_file
