#!/bin/bash

# Define the root directory name
root_dir="test_dir"

# Function to create files with inconsistent naming
create_files() {
    touch "$1/File ONE.txt"
    touch "$1/Second-File.doc"
    touch "$1/3rd file.pdf"
    touch "$1/fourthFile#new.xls"
    touch "$1/5#file.xml"
    touch "$1/5 file.xml"
}

# Check if the test directory exists. If it does, remove it.
if [ -d "$root_dir" ]; then
    echo "Directory $root_dir already exists. Removing it."
    rm -rf "$root_dir"
fi

# Create the root directory
mkdir "$root_dir"
echo "Created directory $root_dir"

# Create files in the root directory
create_files "$root_dir"

# Create a sub-directory and files within it to ignore
mkdir "$root_dir/sub-to-ignore"
echo "Created sub-directory sub-to-ignore within $root_dir"
create_files "$root_dir/sub-to-ignore"

# Create a sub-directory and files within it NOT to ignore
mkdir "$root_dir/sub-to-not-ignore"
echo "Created sub-directory sub-to-not-ignore within $root_dir"
create_files "$root_dir/sub-to-not-ignore"

# Wait for 5 seconds so you have the time to see the changes
duration=5
echo "Waiting for $duration seconds before executing parser.sh"
sleep $duration

# Execute parser.sh

./parser.sh ./$root_dir

echo "Script execution completed."
