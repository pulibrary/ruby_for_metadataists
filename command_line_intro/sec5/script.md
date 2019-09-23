## script: Record Terminal Session

The format of the `script` command is:

```bash
script [ -a ] [ file ]
```
The `script` command records everything displayed on your terminal to a file. If no file is specified, the filename `typescript` is used. To end the script session one types `exit`. This is extremely useful in recreating steps run for documentation purposes.

Example usage:

```bash
yournetid@ruby-office1:~$ script
Script started, file is typescript
yournetid@ruby-office1:~$ pwd
/home/yournetid
yournetid@ruby-office1:~$ cal
July 2016
Su Mo Tu We Th Fr Sa
                1  2
 3  4  5  6  7  8  9
10 11 12 13 14 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 30
31
yournetid@ruby-office1:~$ echo -e "one\ntwo\nthree" | wc -l
3
yournetid@ruby-office1:~$ who
kayiwa   pts/9        2019-08-27 19:37
yournetid@ruby-office1:~$ exit
Script done, file is typescript
```
