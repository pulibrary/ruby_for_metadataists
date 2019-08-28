## tar: File-Archive Tool

`tar` was originally designed for archiving files to tape. It is still useful however in moving entire directory structures between systems.

The format of the `tar` command is:

```bash
tar options directory
```
Tar unlike most Unix commands does not require the `-` before the options. Here are some your instructor uses frequently.

* `c` : Create an archive
* `x` : Extract files from an archive
* `p` : Attempt to save file permission and ownership information
* `v` : Verbose mode
* `t` : Test the archive
* `f` : Use a tar file
* `z` : compress the file using (gzip(1))

As an example let's create a tar file or everything under ~/Desktop.

```bash
yournetid@ruby-office1:~$ cd ~
yournetid@ruby-office1:~$ tar cvpf /tmp/desktop.tar ~/Desktop/
```
This file can then be shared and untarred with

```bash
⋊> ~ tar xvpf /Users/instructorname/Downloads/desktop.tar
```
on another computer and have the same contents.

