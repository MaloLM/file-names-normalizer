#!/bin/bash

# Function definition: parser()
# PARSING RULES
parser() {
 local name="$1"
 # Delete prefix spaces
 name=${name# }

 # Delete suffix spaces
 name=${name% }

 # Convert to lowercase
 name=$(echo "$name" | tr "[A-Z]" "[a-z]")

 # Replace spaces with underscores
 name=$(echo "$name" | sed -r 's/[ ]+/_/g')

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
 name="$(date +%Y%m%d)_$name"
 # Or, as a suffix
 # name="$name_$(date +%Y%m%d)"

 # Remove all dashes and underscores
 # name=$(echo "$name" | tr -d '_-')

 # Ensure file extension is lowercase
 base=${name%.*}
 ext=${name##*.}
 name="$base.${ext,,}"
 
 echo "$name"
}


# Define the path of the temporary file to store file paths
path_file="/tmp/paths.txt"

# Choose the appropriate method based on the operating system
case "$(uname -s)" in
   Darwin)
     # For macOS (Darwin), use 'tail -r' to reverse the output of 'find'
     find . | tail -r > $path_file
     ;;

   Linux)
     # For Linux, use 'tac' to reverse the output of 'find'
     find . | tac > $path_file
     ;;

   *)
     # Default case: also use 'tac' for any other OS
     find . | tac > $path_file
     ;;
esac

# Main loop to process each path in the paths file
while IFS="" read -r p || [ -n "$p" ]
do
  # Extract the last part of the path
  last_part=$(echo "$p" | rev | cut -d "/" -f1 | rev)

  # Compute the length of the full path and the last part
  full_path_length=${#p}
  last_part_length=${#last_part}
  base_path_length=$(($full_path_length - $last_part_length))

  # Check if the base path is longer than 1 character
  if (( $base_path_length > 1 )); then
     # Extract the base path from the full path
     base_path=${p::$base_path_length}

     # Refactor the name of the file using the parser function
     last_part="$(parser "$last_part")"
  fi

  # TODO: Check for duplicate names after refactoring
  # Rename the file if the path has changed and it's not a special case (like . or .DS_Store)
  if [[ "$p" != "$base_path$last_part" ]] && [[ "$p" != "." ]] && [[ "$p" != *".DS_Store" ]]; then
    mv "$p" "$base_path$last_part"
    echo "Modified: from '$p' to '$base_path$last_part'"
  fi

done < $path_file

# Remove the temporary file after processing
rm $path_file
