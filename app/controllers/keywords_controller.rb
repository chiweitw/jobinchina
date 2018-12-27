class KeywordsController < ApplicationController

    def index
        @keywords = Keyword.all
        
    end

    def hot_skills
        @searched_terms = Search.distinct.pluck(:keyword)
    end

    private

    def scrape_get_keyword(url)
        begin
            html_data = open(url).read
            nokogiri_object = Nokogiri::HTML(html_data)
            content = nokogiri_object.css("div.tBorderTop_box").text.gsub(/\s+/, "")
        rescue
            return ""
        end
    end

end
