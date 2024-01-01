# file-names-normalizer

## Overview

This project contains a Bash script designed for renaming files and directory names in a given directory in a standardized way, that you can configure.

It works across different operating systems (macOS and Linux) and modifies file and directory names by performing enabled rules inside the script.

## Demonstration

An example directory with inconsistent naming conventions before script execution:
```
project_directory/
│
├── My_File.txt
├── anotherFile.PNG
├── some report.docx
├── Image 01.JPG
├── CODE_snippet.py
│
└── sub_directory/
    ├── Data Set.csv
    ├── presentation PPT.pptx
    └── README.MD
```

After script execution (assuming base rules configuration):
```
project_directory/
│
├── my_file.txt
├── anotherfile.png
├── some_report.docx
├── image_01.jpg
├── code_snippet.py
│
└── sub_directory/
    ├── data_set.csv
    ├── presentation_ppt.pptx
    └── readme.md
```

## Usage

To quickly start using the `parser.sh` script, simply navigate to the directory where the script is located and run it in your terminal:

```bash
./parser.sh
```

This basic command executes the script in your current working directory. It will process and rename files according to the predefined rules set within the script, making the file names consistent.

For more advanced setup options, detailed installation instructions, please refer to the [Getting Started Guide](./GETTING_STARTED.md). This guide provides comprehensive step-by-step instructions for both Linux and macOS environments, ensuring a thorough and adaptable setup process.

Base configuration inside the parser.sh script applies following configuration:
- changes filename to lowercase
- replaces spaces by underscores
- deletes suffix and prefix spaces

You can edit rules to your own by commenting/uncommenting/adding rules inside the `parser()` function inside the `parser.sh` script. 

## License

This script is licensed under the Apache 2.0 License. See the [LICENSE](./LICENSE) file for details.
  
## Support

For support, please contact the project contributors. 

## Contributors

- [HoloZor](https://github.com/HoloZoR)
- [Malo Le Mestre](https://github.com/MaloLM)

<!-- <a href = "https://github.com/MaloLM/file-names-normalizer/contributors">
   <img src = "https://contrib.rocks/image?repo=MaloLM/file-names-normalizer"/>
</a> -->

## Disclaimer

### Caution When Using in High-Level Directories
**Important**: Exercise extreme caution when running `parser.sh` in high-level directories, especially those containing system or critical files. This script recursively processes and renames files within the directory it's executed in, as well as its subdirectories. Renaming system or essential files can lead to unstable behavior, system malfunctions, or even a non-bootable state of your operating system. 

It's highly recommended to use this script in controlled environments, such as specific folders containing non-critical data. Always ensure you have a clear understanding of the script's effects and have verified its behavior in a safe, isolated directory before using it in any location with significant data.

### Limitation of Liability
The contributors of `parser.sh` bear no responsibility for any damage, data loss, or system instability that may arise from the use of this script. While effort has been made to ensure the script's reliability, its functioning depends on the specific environment and use case. 

As a user, you assume full responsibility for the execution and consequences of this script. It's recommended to perform regular backups of your data and thoroughly test the script in a non-critical environment to understand its behavior and impact before any extensive use. 

Use of `parser.sh` indicates your understanding of these risks and your agreement that the contributors are not liable for any adverse outcomes from its use.
