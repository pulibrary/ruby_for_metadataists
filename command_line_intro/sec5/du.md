## du: Disk usage

The `du` command tells us how much disk space is used by files. The format of the `du` command is:

```bash
du [options] directoryname
```
`du` without any options will show you the amount of space in each subdirectory and the total disk usage. This useful when trying to locate unneeccessary and large files in your directory. These results using pipes can be save a list of the largest files.

```
yournetid@ruby-office1:~$ du --help
yournetid@ruby-office1:~$ du -h ~/Desktop
yournetid@ruby-office1:~$ du -sh ~ | sort -n > ~/diskusage
```
