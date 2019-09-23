## tee: add output to file

The `tee` command takes the format of:

```
tee [ -a ] [ File ]
```

The following command only displays output on the screen (stdout)

```bash
yournetid@ruby-office1:~$ pwd
/home/yournetid
```
The same command directs the output to a file

```bash
yournetid@ruby-office1:~$ pwd > file
yournetid@ruby-office1:~$ cat file
/home/yournetid
```
By using a pipe to `tee` we can display on stdout _AND_ direct to a file

```
yournetid@ruby-office1:~$ pwd | tee file.txt
/home/yournetid
```
