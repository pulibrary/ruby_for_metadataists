# File commands

## home directory ( ~ )

The shell starts your session from a special directory called your home directory.  The tilde (~) character can be used as a shortcut to your home directory. Thus, when you log in, you probably see the command prompt telling you you’re in your home directory:

```bash
yournetid@ruby-office1:~$
```
These prompts are not universal. Our prompt shows the username and the name of the computer as well but there are instances that look like this:

```bash
➜  ~
```

## absolute pathnames

In Unix, all pathnames can be absolute of relative. Absolute means to start from the root directory. Absolute pathnames start with a beginning `/` such as `/usr/bin/who` With absolute filenames, the entire directory path is specified starting with the root directory.

## relative pathnames

Relative pathnames start from the beginning of a directory that you are currently located. These pathnames do not begin with a `/` For example in the previous example if you were in the `/usr` directory, the relative path name to run the who command is `bin/who`
Specifying `../` within a filename goes up one directory. From the the `/usr/bin` directory the who command would be run with `../bin/who`.
The symbol `~` always refers to your home directory.

## ls: Listing Files

The `ls` command lists the files in your directory. The format of this command is:

```bash
ls [options] filenames(s)
```

For each filename listed, if it is a file, information about that file is displayed. If the filename is a directory, information about all the files and subdirectories are displayed.

The `ls` command has many options associated with it. Take a look at some of them by typing:

```bash
yournetid@ruby-office1:~$ ls --help
Usage: ls [OPTION]... [FILE]...
List information about the FILEs (the current directory by default).
Sort entries alphabetically if none of -cftuvSUX nor --sort is specified.
...
```

Some of the most useful ones are:

* `-l`: Prints detailed information about each file. It shows the following information:
  1. File protection for each file (read, write and execute permissions for the owner of the file, people in the same group and the anyone else
  2. Number of files in the subdirectory (if it is a subdirectory)
  3. Owner of the file
  4. Size of the file in bytes
  5. Date the file was last modified
  6. Name of the file
* `-t`: Lists the files in the order of modification date
* `-g`: Shows what group owns the file (we will see `chmod` later for more details)
*  `-a`: Shows hidden files in addition to regular files.

## cat more or less: Show file contents

The `cat`, `more` and `less` commands can be used to show the contents of a file on your terminal screen. To show the contents of the `/etc/motd` file you can do any one of the following:

```bash
yournetid@ruby-office1:~$ cat /etc/motd
```
or

```bash
yournetid@ruby-office1:~$ more /etc/motd
```
or

```bash
yournetid@ruby-office1:~$ less /etc/motd
```
On files smaller than your screen `cat` and `more` work the same way; they differ on how they display files longer than the length of your terminal.

A `cat cli_workshop/data_files/22631-0.txt` will display the entire contents of the file on your screen at once. `less` is modeled on `more` which is an earlier implementation. However, more has fewer features, and you probably shouldn’t bother with it. So, always remember: *less is more*.

## cp: Copy Files

The `cp` command copies files. The Format of the `cp` command is:

```bash
cp [options] from-file(s) to-file
```
or

```bash
cp [options] from-file(s) to-directory
```

The first one copies files within the same directory while the second one copies files into another directory. Let's look at the manual for the `cp` command:

```bash
yournetid@ruby-office1:~$ man cp
```

These are the frequent ones the instructor uses

* `-r`: Recursive. Will recursively copy the files in all the subdirectories.
* `-i`: Interactive. If copying the file, it will overwrite an old version of a file. The `-i` option asks if you want to do the copy. Without the option, it would overwrite the file without asking.
* `-p`: Preserve the permission modes and modification times of the files.

Let's make a few copies of the document by launching our terminal.

```bash
yournetid@ruby-office1:~$ ls
cli_workshop  Desktop  Templates
yournetid@ruby-office1:~$ cp cli_workshop/data_files/22631-0.txt .
yournetid@ruby-office1:~$ ls
22631-0.txt  cli_workshop  Desktop  Templates
```
In order we:

1. `ls` listed contents of our directory
2. `cp` copied from a relative location to our current one. The `.` period represents our current directory
3. `ls` listed contents of our current directory to show the change

However, if the destination is in another directory, the named directory must already exist. Otherwise, the cp command will respond with an error:

```bash
yournetid@ruby-office1:~$ cp cli_workshop/data_files/22631-0.txt gutenberg_books/22631-0.txt
cp: cannot create regular file `gutenberg_books/22631-0.txt`: No such file or directory
```

## mv: Move Files

To move a file instead of copying it, use the `mv` command. The `mv` command can do two things.

1. It can move a file or a directory to another directory
2. It can rename a file of a directory

`mv` uses the following format:

```bash
mv [options] filename to-directoryname
```
or

```bash
mv [options] directoryname to-directoryname
```
or

```bash
mv [options] filename newfilename
```
or

```bash
mv [options] directoryname to-newdirectoryname
```

The directory `to-directoryname` must exist to move the file or directory. If it does not, the `mv` command assumes that you are renaming the file or directory.

These are the frequent `mv` commands the instructor uses:

1. `-i`: Interactive. If moving the file will overwrite a file with the same name without the `-i` option.
2. `-f`: Force. Overrides any file permissions mode restrictions if you are the owner of the file being overwritten.

Let's change the name of our file to something meaningful. And move it to the Desktop

```bash
yournetid@ruby-office1:~$ mv 22631-0.txt timbuctoo.txt
yournetid@ruby-office1:~$ mv timbuctoo.txt Desktop/timbuctoo.txt
```

## rm: Remove Files

Unix handles file removal with the `rm` command. There's no "Trash" stop when this command is run. Very important to remember this.

The format for `rm` is as follows:

```bash
rm [options] filenames(s)
```
Be careful when using the `-r` and `-f` options.

* `-r`: Recursive. Recursively removes all the files and directories
* `-i`: Interactive. Will ask for each file before removing it
* `-f`: Force. Will override any file permissions mode restrictions if you are the owner of the file being removed.

Let's delete the password.txt file which we no longer need.

```bash
yournetid@ruby-office1:~$ ls -l Desktop/
total 24
-rw------- 1 yournetid yournetid 1914 Jul 17 13:17 debian-xterm.desktop
-rw-rw-r-- 1 yournetid yournetid    9 Jul 17 13:18 password.txt
yournetid@ruby-office1:~$ rm -i Desktop/password.txt
```


# File Protection

You can specify the permission of a file or directory:

1. `r`: Read permission
2. `w`: Write permission
3. `x`: Execute permission

|  *Permission* |  *File* | *Directory*  |
|---|---|---|
| `r`  |  Read the file |  List files in Directory |
|  w |  Rewrite or remove file |  Remove any file in directory. Put a file in the directory. Remove the directory itself. |
|  x |  Run executable program |  Read, write or execute any files in the directory |

These permissions can be specified for each of the following categories:

1. `u`: The user - owner of the file
2. `g`: All members in the same group as the owner of the file
3. `o`: Other people
4. `a`: All of the above

The `ls -l` command shows these permissions in order by user, group and others:

```bash
yournetid@ruby-office1:~$ ls -l
total 928
-rw-rw-r-- 1 yournetid yournetid 927212 Jul 20 13:17 22631-0.txt
drwxrwxr-x 4 yournetid yournetid   4096 Jul 19 18:35 cli_workshop
drwx------ 2 yournetid yournetid   4096 Jul 17 17:38 Desktop
drwxrwxr-x 2 yournetid yournetid   4096 Jul 17 13:17 Templates
```
The user `yournetid` has read, write on the `22631-0.txt`

## chmod: Change File Permissions Modes

The `chmod` command is used to change your file or directory permission mode. The format of the `chmod` command is:

```bash
chmod mode filename
```
The mode consists of:

```bash
Category + permission to add permission, or
Category - permission to remove permission
```

For example:

```bash
yournetid@ruby-office1:~$ chmod o+w 22631-0.txt
yournetid@ruby-office1:~$ chmod g-w 22631-0.txt
```
The first command adds write permissions to anyone `22631-0.txt` and the second one removes write permissions to the `yournetid` group.

Another form of the `chmod` command allows an octal number to be used for the mode. This number has the values:

|  *Value* |  *Meaning* |
|---|---|
|  4 |  Read permission allowed |
|  2 |  Write permission allowed |
|  1 |  Execute permission allowed |

A value of six (4+2) allows read and write permission. A value of five (4+1) allows read and execute permission. The numeric form for the mode of the `chmod` command has three digits for:

1. Permission for the owner of the file or directory
2. Group permission of the file or directory
3. Permission for anyone on the system

For example the command:

```bash
yournetid@ruby-office1:~$ chmod 700 22631-0.txt
```

changes the `22631-0.txt` to be executable by the user `yournetid` and no other user can do anything with the file.

## chown: Setting Ownership

In multiuser systems it is often helpful to open file permissions up to other users on a filesystem. Suppose Ritchie, wants to give all Bell Labs access to read and write to the file, `22631-0.txt`. If those users are all part of a group called `belllabs`, then he can give them those permissions by changing the group ownership of the file. He can handle this task with:

```bash
yournetid@ruby-office1:~$ chown :belllabs  22631-0.txt
```


# Directory Commands

In order to logically organize under your home directory, Unix allows you to create subdirectories and put files in them. Let's look at the structure of your home directory.

```bash
yournetid@ruby-office1:~$ tree
```

The `tree` command will list contents of directories in a tree-like format. It is a recursive directory listing program that produces a depth indented listing of files.

## cd: Change Directory

The `cd` command changes the current directory where you are located. It uses the format

```bash
cd directoryname
```

If no `directoryname` is specified your current directory becomes your home directory. The `directoryname` can be an absolute of relative path. A few examples are

```bash
yournetid@ruby-office1:~$ cd
yournetid@ruby-office1:~$ cd /usr/bin
yournetid@ruby-office1:~$ cd ~/Desktop
```

In order the first command takes us to your home directory, the second one takes us to the `/usr/bin` directory and the last one takes us to the `Desktop` directory under your home. It could also be written as `cd /home/yournetid/Desktop`

## mkdir: Make Directories

The `mkdir` command is used to make directories. The format for this is

```bash
mkdir directoryname
```

To make make a new `cliworkshop` directory run the following command:

```bash
yournetid@ruby-office1:~$ mkdir ~/Desktop/cliworkshop
```

## pwd: Print Working Directory

The `pwd` command prints out the full pathname of the directory you are currently located.

# Exercises

1. Specify three ways how `yournetid`may go from `/usr/bin` to his home directory.
1. Using the cp command make a copy of the 22361-0.txt to the `/tmp` directory
1. Instead of using the rm command how can `yournetid` move the 22361-0.txt file to the `/tmp` directory
1. How can `yournetid` change the permission on the 22361-0.txt file so anyone can read it?
1. How can `yournetid` make his Desktop directory so no one except he can read it?


