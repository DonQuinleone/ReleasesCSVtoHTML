# ReleasesCSVtoHTML

## Single Generation

Generating HTML for a single release is simple. Make the `single.sh` script executable, then run it and follow the prompts on-screen. The generated file will appear on your Desktop.

```
chmod +x single.sh
./single.sh
```

## Bulk Generation

Using the template.csv file, produce a pipe-delimited CSV file comprising all release information. Excel cannot produce pipe-delimited CSVs on its own, so once you have a comma-delimited CSV, use a programme like [Table Tool](https://github.com/jakob/TableTool). The CSV should also not wrap content in quotation marks, but it should include the header row.

Then, make the script executable and pass in both your output directory (as an absolute path without a trailing slash) and your pipe-delimited CSV as arguments:

```
chmod +x bulk.sh
./bulk.sh /path/to/output your-data.csv
```


