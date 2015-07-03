#Overview

This shell script is designed to identify any backup files present in a git repository, remove them from the repository (via `git rm`) and optionally commit and push the changes.

## Backup files

Backup files are identified based on their file names ending with an underscore `_` following by a string that represents a date.

The following are examples of file names will be matched by this script.

* `terms_3rdOct2011.php`
* `test_8th_June_2011.php`
* `logout_5thOct2011.php`
* `index_pre23rdOct2012.php`
* `test_260215.php`
* `style_25thJune2015.css`
* `style_31st_May_2013.css`

### Filetypes

This script currently deal with `.php`, `.css`, `.htm` and `.html` files.

##Download

To get the backup deletion script, `cd` to your project's directory and run the following `wget` command.

`wget https://raw.githubusercontent.com/rapidwebltd/backup-deletion/master/backup-deletion.sh`

Please note that you should download the script into a valid git repository. If you do not, it will refuse to run due to its destructive nature.

#Usage

Run the `./backup-deletion.sh` script from within your project's directory.

If you receive a `Permission denied` error, you need to make the script executable with `chmod +x backup-deletion.sh`.

#License
MIT
