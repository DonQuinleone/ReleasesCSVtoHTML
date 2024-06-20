# ReleasesCSVtoHTML

## Preparation

Using the template.csv file, produce a pipe-delimited CSV file comprising all release information. Excel cannot produce pip-delimited CSVs on its own, so once you have a comma-delimited CSV, use a programme like [Table Tool](https://github.com/jakob/TableTool). The CSV should also not wrap content in quotation marks, but it should include the header row.

## Usage

Open the script and define your output directory (`$outdir`). Make sure that this exists.

Then, make the script executable and pass in your pipe-delimited CSV as the first argument of the script:

```
chmod +x convert.sh
./convert.sh your-data.csv
```


