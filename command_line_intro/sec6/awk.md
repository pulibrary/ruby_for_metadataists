## awk: Pattern scanning and processing

The `awk` command allows for complex pattern scanning and processing. `awk` is an entire programming language allowing complex interpreted programs. One of its most powerful features is the print function to reformat the output of other commands. This is the form we will focus on for this section. It uses the following format:

```bash
awk [ -Fcolumn_separator] '{print format_string}'
```
where column\_separator is the character separating columns in the input and format\_string is the new format of the output. By default, the column separator is a space or a tab character. The variables `$1`, `$2`, ... are output fields to put in the format string.

Example use:

```bash
yournetid@ruby-office1:~$ date
Thu Jul 28 13:00:07 EDT 2016
yournetid@ruby-office1:~$ date | awk '{print $2 $3}'
Jul28
yournetid@ruby-office1:~$ date | awk '{ print $2" "$3}'
Jul 28
yournetid@ruby-office1:~$ who
yournetid :0				2016-07-28 13:05 (:0)
yournetid pts/4      	2016-07-28 13:05 (:0.0)
yournetid@ruby-office1:~$ who | awk '{print $1}'
yournetid
yournetid
```
