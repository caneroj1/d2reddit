require_relative 'reddit_scraper.rb'

scraper = RedditScraper::DotaSub.new
scraper.scrape(ARGV[0], ARGV[1], ARGV[2])
