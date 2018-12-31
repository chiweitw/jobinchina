require 'rubygems'
require 'rmmseg'
RMMSeg::Dictionary.load_dictionaries

class GetKeywordsJob < ApplicationJob
  queue_as :default

  def perform(new_record_id)
    # Do something later

    puts "start skill analysis"
    @dashboard = Dashboard.find(new_record_id)
    @search = Search.find_by(keyword: @dashboard.keyword)

    puts @dashboard
    puts @search

    results_en = {}
    results_zh = {}
    word_frequency_en = {}
    urls = @search.job_summary.url
    urls.each do |url|
        puts url
        content = scrape_get_keyword(url)
        word_frequency_en = count_word_frequency_en(content)
        content.gsub!(/[0-9A-Za-z]/, '')
        word_frequency_zh = count_word_frequency_zh(content)
        results_en = results_en.merge(word_frequency_en){|key, oldval, newval| newval + oldval}
        results_zh = results_zh.merge(word_frequency_zh){|key, oldval, newval| newval + oldval}
    end
    results_en = results_en.sort_by{|k, v| v}.reverse.first(20)
    results_zh = results_zh.sort_by{|k, v| v}.reverse.first(20)
    puts results_en
    puts results_zh
    @dashboard.high_freq_en = results_en
    @dashboard.high_freq_zh = results_zh
    @dashboard.save

    
  end

  private

  def scrape_get_keyword(url)
    require 'open-uri'
    begin
        html_data = open(url).read
        nokogiri_object = Nokogiri::HTML(html_data)
        content = nokogiri_object.css("div.tBorderTop_box").text.gsub(/\s+/, "")
    rescue
        return ""
    end
  end

  def count_word_frequency_en(content)
    # for english words
    words = content.scan(/\w*/).select {|word| !word.empty? && word.to_i == 0 && word.size > 1 && word.size <15}
    word_frequency_en = Hash.new(0)
    words.each { |word| word_frequency_en[word.downcase] += 1 }

    stopword_file = 'app/assets/stop_word.json'
    file = File.read(stopword_file)
    stop_words = JSON.parse(file)

    stop_words.each do |word|
        word_frequency_en.delete_if {|key, value| key == word}
    end
    word_frequency_en
  end

    def count_word_frequency_zh(content)

        puts "analysis chinese word freq ..."
        
        stopword_file = 'app/assets/stop_word_zh.json'
        file = File.read(stopword_file)
        stop_words = JSON.parse(file)
        
        stop_words.each do |word|
            content.delete!(word)
        end

        word_frequency_zh = Hash.new(0)
        algor = RMMSeg::Algorithm.new(content)
        loop do
            tok = algor.next_token
            break if tok.nil?
            word = tok.text.force_encoding("UTF-8")
            word_frequency_zh[word] += 1 if word.strip != "" && word.size > 2
        end
        puts word_frequency_zh
    
        word_frequency_zh


    end

end




