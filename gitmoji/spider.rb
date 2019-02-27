require 'kimurai'
require 'byebug'

class GithubSpider < Kimurai::Base
  @name = "github_spider"
  @engine = :mechanize
  @start_urls = ["https://gitmoji.carloscuesta.me/"]
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 1 }
  }

  def parse(response, url:, data: {})
    response.css('.emoji-card .emoji-info').each do |card|
      code = card.css('code').text
      desc = card.css('p').text
      save_to "results.csv", { code: code, desc: desc }, format: :csv
    end
  end

end

GithubSpider.crawl!
