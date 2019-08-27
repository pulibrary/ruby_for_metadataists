## sed: non-interactive editor

`sed` is a **s**tream-oriented **ed**itor. It interprets a script and performs actions on the script. `sed` like many Unix programs, input flows through the program and is directed to standard output. We've already encountered the `sort` command that illustrates this. `sed` commands have the general form:

```bash
sed [options] `command` file(s)
sed [options] -f scriptfile files(s)
```
**Typical uses of `sed` include:**

* Editing one or more files automatically
* Simplifying repetitive edits to multiple files
* Writing conversion programs

Examples usage:

```bash
yournetid@ruby-office1:~$ sed --help
yournetid@ruby-office1:~$ sed s/BSD// < ~/command_line_intro/data_files/operatingsystemlist
yournetid@ruby-office1:~$ sed s/BSD//g < ~/command_line_intro/data_files/operatingsystemlist
yournetid@ruby-office1:~$ sed s/BSD//g < ~/command_line_intro/data_files/operatingsystemlist > nobsdlist
yournetid@ruby-office1:~$ sed -n '/BSD/ p' ~/command_line_intro/data_files/operatingsystemlist
```
