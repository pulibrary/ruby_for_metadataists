## gzip, gunzip, zcat: Compress and uncompress files

The `gzip`, `gunzip`, and `zcat` commands are used to compress files. One can use `tar` with the `-z` option to invoke `gzip`. `gzip` will compress a file, `gunzip` will uncompress it and `zcat` will allow you to review the contents of the `gzip`ped files.

We can compress the contents of our Desktop like we did with the tar command:

```bash
yournetid@ruby-office1:~$ cd ~
yournetid@ruby-office1:~$ gzip --help
yournetid@ruby-office1:~$ gzip -c -r ~/Desktop/ > /tmp/desktop.gz
```

You can compare the sizes of the `tar`red file and the `gzip`ped one using `ls`.

Let's review the contents of the file using `zcat` by piping that into `less`

```bash
yournetid@ruby-office1:~$ zcat /tmp/desktop.gz | less
```

Finally you can send this file much easier to another user who will open it using.

```bash
⋊> ~ gunzip /Users/instructorname/Downloads/desktop.gz
```
[More on gzip](https://www.rootusers.com/11-simple-gzip-examples/)
