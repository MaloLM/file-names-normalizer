#!/bin/bash
path_file="/tmp/paths.txt"

case "$(uname -s)" in # choisis la méthode adapter à l'os
   Darwin)
     find . | tail -r > $path_file
     ;;
   Linux)
     find . | tac > $path_file
     ;;
   *)
     find . | tac > $path_file
     ;;
esac

while IFS="" read -r p || [ -n "$p" ]
do
  last_part=$(echo "$p" | rev | cut -d "/" -f1 | rev)
  full_path_length=${#p} 
  last_part_length=${#last_part}
  base_path_length=$(($full_path_length - $last_part_length)) # Computed length
  echo ""
  echo $full_path_length
  echo $last_part_length

  if (( $base_path_length > 1 )); then
    base_path=$(echo "$p" | cut -b 1-$base_path_length)
    last_part=${last_part# } # delete prefix
    last_part=${last_part% } # delete suffix
    last_part=$(echo "$last_part" | tr "[A-Z]" "[a-z]") # lowercase
    last_part=$(echo "$last_part" | sed -r 's/[ ]+/_/g') # replaces spaces by underscores
    echo ""
    echo ""
    echo $p 
    echo $base_path
    echo $last_part
    if [[ "$p" != "$base_path$last_part" ]] && [[ "$p" != *".DS_Store" ]]; then
      #echo ""
      #echo "$p"
      #echo "$base_path$last_part"
      mv "$p" "$base_path$last_part"
    fi
  fi
  
done < $path_file

rm $path_file