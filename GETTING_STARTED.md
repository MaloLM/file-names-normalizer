# How to Use

This section guides you on how to setup the `parser.sh` script, which is designed to process and rename files in a directory based on specific criteria.

## Approach N°1

### Prerequisites
- Ensure you have a Bash shell environment available.
- The script is compatible with both Linux and macOS systems.

### Installation
1. **Download the Script**: Place `parser.sh` in your desired directory.

2. **Make the Script Executable**: To allow the script to run, change its permissions to make it executable. Open your terminal and navigate to the directory containing `parser.sh`. Execute the following command:

    ```bash
    chmod +x parser.sh
    ```

### Running the Script
- **Execute in Current Directory**: To run the script in your current working directory, use:

    ```bash
    ./parser.sh
    ```

- **Execute from Any Location**: To run `parser.sh` from any location:

    1. Add the script's directory to your PATH. Edit your `~/.bashrc` or `~/.bash_profile`:

        ```bash
        export PATH=$PATH:/path/to/script
        ```

    2. Update your current session:

        ```bash
        source ~/.bashrc
        ```

    3. Now, you can run the script from anywhere:

        ```bash
        parser.sh
        ```

## Notes about this approach
- Run the script in a directory where you have permission to modify files.
- The script recursively processes all files in the current directory and subdirectories. Ensure this is appropriate for your use case.
- Special files like `.DS_Store` (macOS) are excluded from renaming.
- It's advised to first test the script in a safe, non-critical directory to ensure it works as expected in your environment.

## Approach N°2: System-Wide Command Setup

You can configure the `parser.sh` script to be a recognizable command in the CLI on both Linux and macOS. This involves placing the script in a standard location for executable files and ensuring it's included in your system's `PATH` environment variable.

### 1. Place the Script in a Standard Location

Common locations for custom scripts are `/usr/local/bin` or `~/bin`. These directories are included in the system's `PATH`, making any executable script within them accessible from anywhere.

- **For System-wide Access**: Use `/usr/local/bin`. This requires administrative privileges:

  ```bash
  sudo cp parser.sh /usr/local/bin/parser
  ```

  This command copies `parser.sh` to `/usr/local/bin` and renames it to `parser` for ease of use.

- **For User-specific Access**: Use `~/bin` (create it if it doesn't exist):

  ```bash
  mkdir -p ~/bin
  cp parser.sh ~/bin/parser
  ```

### 2. Make the Script Executable

Ensure the script is executable:

```bash
chmod +x /usr/local/bin/parser  # System-wide
# or
chmod +x ~/bin/parser  # User-specific
```

### 3. Add the Directory to the PATH (if necessary)

- If you placed the script in `~/bin` and it's not already in your `PATH`, add it:

  ```bash
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
  # For macOS, use ~/.bash_profile instead
  source ~/.bashrc
  # For macOS, use source ~/.bash_profile
  ```

### 4. Use the Command

After these steps, you should be able to use `parser` as a command from any directory:

```bash
parser
```

### Notes about this approach

- Placing scripts in `/usr/local/bin` makes them accessible to all users on the system, so ensure that this is your intention.
- Always be cautious when adding scripts to your `PATH` and ensure that they are secure and trusted, as this could pose a security risk if misused.
- Remember that any changes to `.bashrc` or `.bash_profile` only apply to Bash. If you're using a different shell (like Zsh, which is default on newer macOS versions), you need to modify the corresponding configuration file for that shell (like `~/.zshrc` for Zsh).


## Troubleshooting

### General Troubleshooting Steps

1. **Script Not Found or Permission Denied**:
   - Ensure the script is in the correct directory and you have navigated to that directory.
   - Verify that the script has execute permissions:
     
     ```bash
     chmod +x parser.sh
     ```
   - If using Approach N°2, ensure the script has been copied to the right system directory and renamed correctly.

2. **Command Not Recognized After Adding to PATH**:
   - Confirm that the correct path is added to your `PATH` environment variable. Use `echo $PATH` to check.
   - If changes were made to `.bashrc` or `.bash_profile`, ensure you've reloaded the configuration:
     
     ```bash
     source ~/.bashrc
     # or for macOS:
     source ~/.bash_profile
     ```

### Specific Issues for Approach N°1

1. **Script Executes But Does Nothing**:
   - Check if the script is being run in a directory with files that match the criteria for renaming.
   - Ensure there are no special permissions or read-only settings on the files you are trying to rename.

2. **Errors When Running from Any Location**:
   - If `parser.sh` isn't recognized after adding its directory to PATH, check for typos in the `PATH` export command and ensure the correct path is added.

### Specific Issues for Approach N°2

1. **Permission Issues When Copying to `/usr/local/bin`**:
   - Ensure you have administrative privileges. You might need to use `sudo` to copy the script to `/usr/local/bin`.

2. **Script Not Executing System-Wide**:
   - Confirm the script is located in `/usr/local/bin` or `~/bin` and is executable.
   - For multiple user environments, check if other users have read and execute permissions for the script.

### Additional Tips

- If you encounter syntax errors, ensure your environment is using Bash. Some systems default to other shells.
- For complex issues, run the script with debug mode on to see more detailed output:

  ```bash
  bash -x parser.sh
  ```

- Always back up important files before running scripts that modify file names to prevent accidental data loss.