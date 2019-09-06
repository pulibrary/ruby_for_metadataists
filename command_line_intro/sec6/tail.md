## tail: Display the end of a file

The format of the `tail` command is:

```bash
head [ -count ] [ file ]
```
`tail` displays the end of the file to standard output. If no file is named, the standard input is used.
The output displayed begins at distance + number from the beginning or -number  from the end of input. Number is counted in units of lines, blocks or characters, based on the appended option `l`, `b` or `c`. The default unit if none is specified is lines.

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
yournetid@ruby-office1:~$ tail --help
yournetid@ruby-office1:~$ tail -2 command_line_intro/data_files/operatingsystemlist
Centos      Linux           2016-02
Gentoo      Linux           2016-07
```
