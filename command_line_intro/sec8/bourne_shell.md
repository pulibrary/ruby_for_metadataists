## Bourne shell

We have thus far used the shell interactively. The shell prompted us for commands to execute and interpreted special shell symbols. The shell is capable of executing commands from a file as well as prompting for commands to execute.

Our first example is a `dayoftheweek.sh` file. Using your editor create a file named `dayoftheweek.sh` which will have the following:

```bash
#!/bin/sh
#
# dayoftheweek
#
# This program prints out the day

date | awk '{print $1}'
```
### Automatic Shell Execution

Placing a `#!` at the beginning of a program automatically executes a shel. The `#!` must be the first line of the program, and it must start in the first column.
To run this program, the user needs to execute permission on the file `dayoftheweek.sh` You can do that on our file with

```bash
chmod a+x dayoftheweek.sh
```
### Shell Symbols

All of the special shell symbols such as

```bash
| < > >> & |& >&
```
may be used in a shell program. This is an example of a script that will print the names of users logged into the system. Let's create a shell script named in our text editor `sortedwho.sh`

```bash
#!/bin/sh
#
# sorted who
#
# print a list of who is on the system, sorted by username
# The date is at the top of the list
date > /tmp/wholist
who | sort >> /tmp/wholist
less /tmp/wholist
```

You can either change the permissions of this file to be executable or run

```bash
sh sortedwho.sh
```

### Variables

Just about every programming language has the concept of variables - a symbolic name for a chunk of memory to which we can assign values, read and manipulate its contents. Let's create a new script named `readexpr.sh`


```bash
#!/bin/sh
#This script introduces the read command which can be used for input
#  readexpr
#
# it also introduces the expr command can be used to evaluate an expression
echo "Enter an integer: \c"
read int1
echo "Enter another integer: \c"
read int2
int3=`expr $int1 + $int2`
echo "Sum = $int3 and Difference = `expr $int1 - $int2`"
echo "That is all"
```
