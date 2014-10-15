require 'mechanize'

module RedditScraper
  class DotaSub
    attr_reader :url
    attr_accessor :last_post

    def initialize
      @last_post = ""
      @url = "http://www.reddit.com/r/dota2/?count=25"
    end

    def scrape(domain, scores, pages = nil)
      domain ||= "self"
      scores ||= false
      pages ||= 1
      agent = Mechanize.new

      pages.to_i.times do |time|
        tmp = []
        url = @url << "&after=#{@last_post}"
        puts "************** PAGE = #{time + 1} **************"
        page = agent.get(url)
        page.search('div.entry').each { |item| tmp.push(item) }

        @last_post = page.search('div.thing').last.attribute("data-fullname")

        arr = create_data(tmp, domain)
        output_data(arr, eval(scores), page)
      end
    end

    private
    def get_scores_for_post(page, title)
      res = -1
      page.search('div.thing').each { |item| res = item.children[2].children[2].text if !item.children[3].children[0].text[title].nil? }
      res
    end

    def create_data(tmp, domain)
      data = []
      tmp.each do |element|
        title = element.children[0].children[0].text
        type = element.children[0].children.count.eql?(4) ? element.children[0].children[3].text : element.children[0].children[2].text
        link = element.children[0].children[0][:href]

        data.push({ title: title,
                    type: type,
                    link: "reddit.com/#{link}" }) if type[domain]
      end
      data
    end

    def output_data(data, scores, page)
      data.each do |item|
        puts "-------\nTitle: #{item[:title]}\cnType: #{item[:type]}\nLink: #{item[:link]}"
        puts "Score: #{get_scores_for_post(page, item[:title])}" if scores
      end
    end
  end
end
