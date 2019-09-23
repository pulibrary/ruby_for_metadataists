## csvkit: utilities for converting to and working with CSV

`csvkit` is to tabular data what the standard Unix text processing suite (grep, sed, cut, sort) is to text, is how the software developers describe this tool and they are not wrong.

We will follow the excellent tutorial from the tool's documentation.

### in2csv: the Excel killer


For purposes of this tutorial, I've converted this data to Excel format. (NPR published it in CSV format.) If you have Excel you can open the file and take a look at it, but really, who wants to wait for Excel to load? Instead, let's make it a CSV:

```bash
in2csv ~/command_line_intro/data_files/ne_1033_data.xlsx
```

You should see a CSV version of the data dumped into your terminal. All csvkit tools write to the terminal output ("standard out") by default. This isn't very useful, so let's write it to a file instead:

```bash
in2csv ~/command_line_intro/data_files/ne_1033_data.xlsx > data.csv
```

`data.csv` will now contain a CSV version of our original file.

`in2csv` will convert a variety of common file formats, including xls, xlsx and fixed-width into CSV format.

### csvlook: data periscope


Now that we have some data, we probably want to get some idea of what's in it. We could open it in Excel or Google Docs, but wouldn't it be nice if we could just take a look in the command line? Enter csvlook:

```bash
csvlook data.csv
```

Now at first the output of `csvlook` isn't going to appear very promising. You'll see a mess of data, pipe character and dashes. That's because this dataset has many columns and they won't all fit in the terminal at once. To fix this we need to learn how to reduce our dataset before we look at it.


### csvcut: data scalpel


`csvcut` is the original csvkit tool, the one that started the whole thing. With it, we can slice, delete and reorder the columns in our CSV. First, let's just see what columns are in our data:

```bash
csvcut -n data.csv
```


As you'll can see, our dataset has fourteen columns. Let's take a look at just columns ``2``, ``5`` and ``6``:

```bash
csvcut -c 2,5,6 data.csv
```

Now we've reduced our output CSV to only three columns.

We can also refer to columns by their names to make our lives easier:

```bash
csvcut -c county,item_name,quantity data.csv
```

### Putting it together with pipes


Now that we understand `in2csv`, `csvlook` and `csvcut` we can demonstrate the power of csvkit's when combined with the standard command-line "pipe". Try this command:

```bash
csvcut -c county,item_name,quantity data.csv | csvlook | head
```

All `csvkit` tools accept an input file as "standard in", in addition to as a filename. This means that we can make the output of one csvkit tool become the input of the next. In this case, the output of `csvcut` becomes the input to `csvlook`. This also means we can use this output with standard Unix commands such as `head`, which prints only the first ten lines of its input. Here, the output of `csvlook` becomes the input of `head`.

Pipeability is a core feature of csvkit. Of course, you can always write your output to a file using `>`, but many times it makes more sense to use pipes for speed and brevity.

Of course, we can also pipe `in2csv`, combining all our previous operations into one:

```bash
in2csv ne_1033_data.xlsx | csvcut -c county,item_name,quantity | csvlook | head
```


## Examining the data


### csvstat: statistics without code


In the previous section we saw how we could use `csvlook` and `csvcut` to peek at slices of our data. This is a good starting place for diving into a dataset, but in practice we usually want to get the widest possible view before we start diving into specifics.

`csvstat` is designed to give us just such a broad picture of our data. It is inspired by the summary() function from the computational statistics programming language `"R" <http://www.r-project.org/>`_.

Let's examine summary statistics for some selected columns from our data (remember you can use `csvcut -n data.csv` to see the columns in the data):

```bash
csvcut -c county,acquisition_cost,ship_date data.csv | csvstat
```

`csvstat` algorithmically infers the type of each column in the data and then performs basic statistics on it. The particular statistics computed depend on the type of the column.

In this example the first column, `county` was identified as type "unicode" (text). We see that there are `35` counties represented in the dataset and that `DOUGLAS` is far and away the most frequently occurring. A quick Google search shows that there are `93` counties in Nebraska, so we know that either not every county received equipment or that the data is incomplete. We can also find out that Douglas county contains Omaha, the state's largest city by far.

The `acquisition_cost` column is type "float" (number including a decimal). We see that the largest individual cost was `412,000`. (Probably dollars, but let's not presume.) Total acquisition costs were `5,438,254`.

Lastly, the `ship_date` column shows us that the earliest data is from ``1984`` and the latest from `2054`. From this we know that there is invalid data for at least one value, since presumably the equipment being shipped does not include time travel devices. We may also note that an unusually large amount of equipment was shipped in April, 2013.

As a journalist, this quick glance at the data gave me a tremendous amount of information about the dataset. Although we have to be careful about assuming to much from this quick glance (always double-check the numbers!) it can be an invaluable way to familiarize yourself with a new dataset.

### csvgrep: find the data you need


After reviewing the summary statistics you might wonder what equipment was received by a particular county. To get a simple answer to the question we can use `csvgrep` to search for the state's name amongst the rows. Let's also use `csvcut` to just look at the columns we care about and `csvlook` to format the output:

```bash
csvcut -c county,item_name,total_cost data.csv | csvgrep -c county -m
```

`LANCASTER` county contains Lincoln, Nebraska, the capital of the state and its second-largest city. The `-m` flag means "match" and will find text anywhere in a given column--in this case the `county` column. For those who need a more powerful search you can also use `-r` to search for a regular expression.

### csvsort: order matters


Now let's use `csvsort` to sort the rows by the `total_cost` column, in reverse (descending) order:

```bash
csvcut -c county,item_name,total_cost data.csv | csvgrep -c county -m LANCASTER | csvsort -c total_cost -r | csvlook
```

Two interesting things should jump out about this sorted data: that `LANCASTER` county got a very expensive `MINE RESISTANT VEHICLE` and that it also go three other `LIGHT ARMORED VEHICLE`.

What commands would you use to figure out if other counties also received large numbers of vehicles?
