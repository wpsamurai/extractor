# Extractor

## About
Simple Ruby script to parse files. Depends on the pareser selected returns different data from the source file.

## Installation

```ruby
$ bundle install
```

## Usage
```
$ ./extractor.rb [options] file
```

## Options
```
    -p, --parser=PARSER              Select parser (default: logs)
    -h, --help                       Displays help
```

### Parser
You can select between following parsers:
- `logs` - process Varnish log files
- `xml` - process Google Product XML Data feed files
- `json` - process json file


## Examples
Process local Varnish file
```
$ ./extractor.rb spec/fixtures/varnish.log
Top 5 hosts
+-------------------+------+
| Hostname          | Hits |
+-------------------+------+
| www.example.no    | 412  |
| static.example.no | 340  |
| 2.example.no      | 169  |
| 1.example.no      | 157  |
| 3.example.no      | 120  |
+-------------------+------+
Top 5 files
+-----------------------------------------------------+------+
| File                                                | Hits |
+-----------------------------------------------------+------+
| http://www.example.no/api/js/videoiframe.js         | 19   |
| http://www.example.no/innstikk/feed_3spalter_ny.php | 17   |
| http://www.example.no/tv-guide/schedule.php         | 15   |
| http://www.example.no/feed_3spalter2_ny.php         | 14   |
| http://2.vexample.no/drfront/images/2012/05/23.jpg  | 14   |
+---------------------------------------------------- +------+
```

Process XML file from the web
```
$ ./extractor.rb -p xml https://feeds.example.com/8946.xml
+-----------------------------------------------------------------------------+------------+-----+
| Title                                                                       | Price      | Url |
+-----------------------------------------------------------------------------+------------+-----+
| [Sample] Roxy, time warp tie dye mini New                                   | 19.0 EUR   |     |
| big image bub test New                                                      | 25.0 EUR   |     |
| [Sample] Anna, bright single bangles Anna New                               | 29.0 EUR   |     |
| [Sample] Levi's, blue denim womens shirt Levi's New                         | 29.0 EUR   |     |
| [Sample] Insight, black tee with white print New                            | 29.0 EUR   |     |
+-----------------------------------------------------------------------------+------------+-----+
```

Process JSON file from the FTP
```
$ ./extractor.rb -p json ftp://user:pass@ftp.example.com/feed.json
+------------------------------------------------------+---------+---------------------------------------------------+
| Title                                                | Price   | Url                                               |
+------------------------------------------------------+---------+---------------------------------------------------+
| Cullmann CB6.3 Magic SystemPod Stativ                | 120.0   | http://example.de/products/cullmann               |
| DEH-6300SD                                           | 129.0   | http://example.de/products/deh-6300sd             |
| Canon Speedlite 90EX                                 | 129.0   | http://example.de/products/canon-speedlite-90ex   |
| Canon GPS-Empfänger GP-E2                            | 243.99  | http://example.de/products/canon-gps-empfaenger   |
| Canon Akkugriff BG-E11                               | 286.0   | http://example.de/products/canon-akkugriff-bg-e11 |
+------------------------------------------------------+---------+---------------------------------------------------+

```
