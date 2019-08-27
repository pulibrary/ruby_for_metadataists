## wc: List number of lines, word and characters

The format for the `wc` command is

```bash
wc [ -lwc ] [ name ]
```
`wc` counts the number of lines, words, and characters in the named files, or in the standard input. The definition of "word" is a string of characters separated by spaces, tabs, or new lines.

Example usage:

```bash
yournetid@ruby-office1:~$ cat ~/command_line_intro/data_files/names.txt
yournetid@ruby-office1:~$ wc --help
yournetid@ruby-office1:~$ wc ~/command_line_intro/data_files/names.txt
yournetid@ruby-office1:~$ wc -cw ~/command_line_intro/data_files/names.txt
```
