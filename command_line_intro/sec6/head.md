## head: Display the beginning of a file

The format of the `head` command is

```bash
head [ -count ] [ file ]
```
where count is the number of lines from the top of the program to display. If no count is given, the default value is 10. When no file is specified is specified, the input comes from standard input.

Example usage:

```bash
yournetid@ruby-office1:~$ cat command_line_intro/data_files/operatingsystemlist
OpenBSD     BSD             2016-03
FreeBSD     BSD             2016-04
NetBSD      BSD             2015-09
Dyson       Illumos         2015-07
SmartOS     Illumos         2016-07
OpenIndiana Illumos         2016-04
Debian      Linux           2016-06
Centos      Linux           2016-02
Gentoo      Linux           2016-07
```

```bash
yournetid@ruby-office1:~$ head --help
yournetid@ruby-office1:~$ head -2 command_line_intro/data_files/operatingsystemlist
OpenBSD     BSD             2016-03
FreeBSD     BSD             2016-04
yournetid@ruby-office1:~$ head -2 command_line_intro/* | cat
```
