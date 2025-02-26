# assembly_blis
CS11 Assembly Project - University Enrollment System
## How to Run

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/assembly_blis.git
    ```
2. Navigate to the project directory:
    ```sh
    cd assembly_blis
    ```
3. Assemble the code using build.ps1:
    ```sh
    ./build sting
    ```

### File Descriptions

1. .gitignore
    ```
    Add in here the file extensions of the files you don't want to be pushed to the repo.
    ```
2. build.ps1
    ```
    Windows script to immediately build and link the assembly code
    ```
3. base folder
    ```
    Contains the necessary txt files to display
    ```
4. helper folder
    ```
    Contains the functions to help tidy up the main asm file
    ```

### Note for PowerShell Users

If you encounter an execution policy error, run the following command:
```sh
Set-ExecutionPolicy Unrestricted -Scope Process
```