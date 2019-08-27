# getting in and out

To use our ruby-office1 system you must log in with a username and password. For this workshop you will have a virtual machine with your princeton netid and a public key.

For our first exercise let's change the password by typing the following

## online help

All the documentation about the Unix system is available using the online help facility. Every topic has a manual page describing it; commands have a manual page on how to use the.

Each manual page is indexed by the name of the command or system call and a one-line description of what it does. Suppose you needed to find the spelling of word in a documents you have. You can search your system for the keyword using the following format. `man -k keyword`

To search all topics related to spell checking we'd use:

```bash
yournetid@ruby-office1:~$ man -k spell
aspell-autobuildhash (8) - Autobuilding aspell hash files for some dicts.
...
ispell-wrapper (1)    - smart wrapper for ispell
```

The elipses represent skipped content. To display the actual page manual type:

```bash
man 1 ispell-wrapper
ISPELL-WRAPPER(1)                                                                             ISPELL-WRAPPER(1)

NAME
       ispell-wrapper - smart wrapper for ispell

SYNOPSIS
        ispell-wrapper [--emacs=name] [--language=regexp] [--dry-run] [ispell options] file
...
```

If you do not type in a section number, the sections will be searched in order (1,2,3,..) for the topic. Let's find out about the sections by typing:

```bash
yournetid@ruby-office1:~$ man man

MAN(1)                                         Manual pager utils                                        MAN(1)



NAME
       man - an interface to the on-line reference manuals

SYNOPSIS
       man  [-C  file]  [-d] [-D] [--warnings[=warnings]] [-R encoding] [-L locale] [-m system[,...]] [-M path]
       [-S list] [-e extension] [-i|-I]  [--regex|--wildcard]  [--names-only]  [-a]  [-u]  [--no-subpages]  [-P
       pager]  [-r  prompt]  [-7]  [-E  encoding]  [--no-hyphenation]  [--no-justification]  [-p  string]  [-t]
       [-T[device]] [-H[browser]] [-X[dpi]] [-Z] [[section] page ...] ...
       man -k [apropos options] regexp ...
...
```

Several things to note:

* There are several different sections of the online manual. This man document is located in section 1 of the manual as highlighted in the top left. There is another manual page titled `man` in section 7.
* Anything in the `[]` brackets is optional.
* The man command has several options associated with it. In Unix,  options are specified with a `-` (for short format) and `--` (for long format) followed by the option. `(-f, -k, -m)`
* As demonstrated earlier you can look for information about a command without knowing anything about the name of the command. `man -k spell` printed a list of all manual pages that have `spell` in the name or description.

In addition to this most commands will use the `-h` or `--help` flag. Let's try it with our result from before

```bash
yournetid@ruby-office1:~$ ispell-wrapper -h
Usage: ispell [-dfile | -pfile | -wchars | -Wn | -t | -n | -H | -x | -b | -S | -B | -C | -P | -m | -Lcontext | -M | -N | -Ttype | -ktype kws | -Fpgm | -V] file .....
       ispell [-dfile | -pfile | -wchars | -Wn | -t | -n | -H | -Ttype | -ktype kws | -Fpgm] -l
       ispell [-dfile | -pfile | -ffile | -Wn | -t | -n | -H | -B | -C | -P | -m | -Ttype | -ktype kws | -Fpgm] [-a | -A]
       ispell [-dfile] [-wchars | -Wn] -c
       ispell [-dfile] [-wchars] -e[1-4]
       ispell [-dfile] [-wchars] -D
...
```

An alternative to the `man -k keyword` is the `apropos` tool. You can search the man pages for keywords with a command called apropos. Let’s say you want to know what text editors are available. You might do our earlier search for the string “text editor”:

```bash
yournetid@ruby-office1:~$ apropos "text editor"
ed (1)               - line-oriented text editor
editor (1)           - Vi IMproved, a programmers text editor
ex (1)               - Vi IMproved, a programmers text editor
red (1)              - line-oriented text editor
rview (1)            - Vi IMproved, a programmers text editor
rvim (1)             - Vi IMproved, a programmers text editor
vi (1)               - Vi IMproved, a programmers text editor
view (1)             - Vi IMproved, a programmers text editor
vim (1)              - Vi IMproved, a programmers text editor
```

# Exercises

1. Use the online manual to find which command line editors are available
2. Use the online manual to find out how to list files
