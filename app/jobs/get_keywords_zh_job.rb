# class GetKeywordsZhJob < ApplicationJob
#   queue_as :default

#   def perform(dashboard, content)
#     # Do something later

#     puts "start chinese word freq analysis"
#     @dashboard = dashboard
#     @search = Search.find_by(keyword: @dashboard.keyword)

#     puts @dashboard
#     puts @search

#     results_zh = {}
#     urls = @search.jobs.map{|i| i.url}
#     urls.each do |url|
#         puts url
#         content = scrape_get_keyword(url)
#         content.gsub!(/[0-9A-Za-z]/, '')
#         word_frequency_zh = count_word_frequency_zh(content)
#         results_zh = results_zh.merge(word_frequency_zh){|key, oldval, newval| newval + oldval}
#     end
#     results_zh = results_zh.sort_by{|k, v| v}.reverse.first(20)
#     puts results_zh
#     @dashboard.high_freq_zh = results_zh
    
#     @dashboard.save
#   end

#   private

#   def count_word_frequency_zh(content)
    
#     stopword_file = 'app/assets/stop_word_zh.json'
#     file = File.read(stopword_file)
#     stop_words = JSON.parse(file)
    
#     content = content

#     stop_words.each do |word|
#         content.delete!(word)
#     end

#     puts "after stopword... #{content}"

#     word_frequency_zh = Hash.new(0)
#     word_initial_length = 2
#     word_limit_length = 6

#     (word_initial_length...word_limit_length).each do |length|
#         content.split("").each_slice(length).to_a.each do |word_array|
#             word = word_array.join("")
#             word_frequency_zh[word] += 1 
#         end
#     end
#     word_frequency_zh
#   end
# end
