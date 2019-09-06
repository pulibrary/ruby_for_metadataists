## sort: sort files

The `sort` command sorts infomation in files. We've already used it in the workshop but we will look at it in more detail as a filter. Until now we've used it generically but sort uses this format

```bash
sort [ - bdfnrtx ] [ +pos1 [ -pos2] ] [ -T directory ] [ name ]
```
By default, sort orders the entire lines starting in the first column. This is how we have used it until now. `sort` is used most frequently by your instructor in the following ways:

* `-b` : Ignore leading blanks
* `-d` : Only letters, digits and blanks are significant in comparisons.
* `-f` : Not case-sensitive
* `-n` : Sort in numeric order
* `-r` : Sort in descending order
* `-k` : Restrict a sort key that has the starting position field1, and optional ending position field2 of a key field.

Example Usage:
We have a an example of list with Operating Systems separated by tab characters.

```bash
yournetid@ruby-office1:~$ cd ~
yournetid@ruby-office1:~$ cat ~/command_line_intro/data_files/operatingsystemlist
yournetid@ruby-office1:~$ sort -r -k2 ~/command_line_intro/data_files/operatingsystemlist
```

