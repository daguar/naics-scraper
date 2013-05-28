# naics-scraper 

## About

A simple Ruby scraper for getting the content of NAICS code descriptions from the US Census web site and storing them in a Mongo data store.

### Current Status

Current status is: **experimental**

It seems to work for the core content for 2012 codes -- it has not yet been tested on other years.

A good way to help is to check out the JSON of 2012 code scraping results, and open an Issue for any problems you discover.

## Installing

### Requirements

* Ruby (built on 1.9.3)
* MongoDB
* Gems included in Gemfile

### Getting Started

To run the scraper, do the following:

First, in a separate terminal window, start Mongo:

`mongodb`

Next, from the project directory, install gems:

`bundle install`

Then, run the script:

`ruby naics_scraper.rb`

You're now at an interactive terminal, from which you can run any of the scraping commands (read the code to get a sense for what you can do).

The main way to get all the data for a year is to do:

`NaicsScraper.put_year_content_in_mongo(2012)`

The scraper uses VCR to cache responses locally, both for web-citizenry purposes and to speed up testing new content-scraping approaches.

## Contributing

Shoot on over a GitHub Issue. This is very much a script right now, so no formal process for contributing.

## Contact

You can totally tweet at me! [https://twitter.com/allafarce](https://twitter.com/allafarce)

## License

Open source under the BSD\* license (see LICENSE.md for full details)

\* Go bears!
