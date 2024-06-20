# ReleasesCSVtoHTML

## Preparation

Using the template.csv file, produce a pipe-delimited CSV file comprising all release information. Excel cannot produce pipe-delimited CSVs on its own, so once you have a comma-delimited CSV, use a programme like [Table Tool](https://github.com/jakob/TableTool). The CSV should also not wrap content in quotation marks, but it should include the header row.

## Usage

Then, make the script executable and pass in both your output directory (as an absolute path without a trailing slash) and your pipe-delimited CSV as arguments:

```
chmod +x convert.sh
./convert.sh /path/to/output your-data.csv
```


