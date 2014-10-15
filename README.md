d2reddit
========

This is just some ruby code to scrape on the dota 2 subreddit.

The scraper accepts 2 command-line parameters and an optional third.
<ul>
<li>parameter 1: the reddit domain to select for posts on a page. for example: if the domain chosen is "youtube", the scraper will only select posts that link to youtube videos.</li>

<li>parameter 2: either true or false, indicating if you want the reddit scores to be included in the results.</li>

<li>parameter 3 (optional): an integer indicating the number of pages to be scraped</li>

The scraper can be run as follows, using example.rb in lib:
<ul>
```ruby
ruby example.rb imgur true 1
```

The scraper simply outputs the title of each post, the url it links to, and its score depending on the parameters.
