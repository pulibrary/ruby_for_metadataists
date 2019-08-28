## cut: remove sections of a file

The format for the `cut` command is:

```bash
cut options directory
```

Example usage:

```bash
yournetid@ruby-office1:~$ cat ~/command_line_intro/data_files/cut_example.txt
tr command for translations.
du command for disk usage
ls command is an interactive calculator
wc command lists number of lines
yournetid@ruby-office1:~$ cat --help
yournetid@ruby-office1:~$ cut -c4 ~/command_line_intro/data_files/cut_example.txt
c
c
c
c
```
extracts only a desired column from a file using the `-c` option.

```bash
yournetid@ruby-office1:~$ cut -c4-6 ~/command_line_intro/data_files/cut_example.txt
com
com
com
com
```
