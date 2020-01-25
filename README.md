# BackupServer
These shell scripts are built for backup the server important data. We designed several well-known backup situations that include websites, databases, and configurations respectively.

## Deployment instructions
1. You have to decide where you attempt to store **the backup files** and **backup log files**.
2. Modify the backup file path and the log file path for each shell scripts. You can get details in the ["Shell scripts section"](#Shell-scripts) of README.
3. Check the "Call backup section" in each shell scripts. You should modify the parameters that you input to the BACKUP function to fit your requirements.
    ```
    ## Call backup section.
    ## Backup Database
    ## Parameter1: Database name.
    ## Parameter2: The domain name related to this database.
    BACKUP 'wordpress_db' 'www.brilliantcode.net'
    BACKUP 'wp_testing_db' 'testing.brilliantcode.net'
    ```
4. Add execute premission to shell script.
    ```
    $ sudo chmod +x database_bak.sh
    ```
5. Launch the shell script.
    ```
    $ sudo ./database_bak.sh
    ```
6. Do NOT ever add any <kbd>space</kbd> against both sides of <kbd>=</kbd> word, if you want to make some modifications.

## Shell scripts
We list the variables that you have to change before launch.

- website_bak.sh
  - Backup file path: SITE_DIR
  - Log file path: LOG_FILE

- database_bak.sh
  - Backup file path: DB_DIR
  - Log file path: LOG_FILE
  - Database power user name: DB_USER
  - Database power user passwords: DB_PWD

- config_bak.sh
  - Backup file path: CNF_DIR
  - Log file path: LOG_FILE
