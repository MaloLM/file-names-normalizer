## Test

The `file-names-normalizer` project includes a comprehensive testing mechanism to ensure the reliability and functionality of the `parser.sh` script before it is used in real-world scenarios. This testing is crucial for confirming that the script behaves as expected and does not inadvertently cause issues with file and directory naming.

### Test Script - `test.sh`

Alongside `./scripts/parser.sh`, there is a dedicated test script named `test.sh`. This script is designed to simulate a real-world environment by creating a directory filled with files and subdirectories, each having various naming conventions that intentionally do not follow a standard format. The purpose of this setup is to closely mimic the types of files and directories that `parser.sh` is expected to handle in a typical use case.

### How It Works

1. **Environment Setup**: `test.sh` starts by creating a test environment, a directory with a set of files and subdirectories. These files are named with a mix of uppercase and lowercase letters, spaces, special characters, and different file extensions. This variety ensures that the script is tested against a wide range of file naming scenarios.

2. **Script Execution**: After setting up the test environment, `test.sh` then executes `parser.sh` on this directory. This process allows you to observe how `parser.sh` interacts with various file and directory names, applying normalization rules as configured in the script.

3. **Verification and Analysis**: Post-execution, you can manually inspect the directory to verify that the files and subdirectories have been renamed (or ignored) according to the predefined rules in `parser.sh`. This step is crucial for ensuring that the script functions correctly and consistently.

### Customization for Specific Testing Needs

You have the flexibility to modify `test.sh` to suit specific testing requirements. For instance, if you want to test additional naming conventions or special characters not covered in the default setup, you can edit `test.sh` to include these scenarios. This customization allows for a more thorough and tailored testing process, ensuring that `parser.sh` is robust and reliable in various situations.