class AutoScrappingJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    all_keywords = Search.select(:skills).map{|i|i.skills}.flatten.delete_if{|n| n.class == Integer}

    all_keywords.each do |keyword|
      new(keyword)
    end
  end

  def new(keyword)
    @search = Search.create!(keyword: keyword)
    @keyword = keyword.scan(/\w*/).join(" ")
    # if @keyword.empty? || @keyword.strip == ""
    #     puts "Chinese..."
    #     @keyword = search_params['keyword'].strip
    #     puts @keyword
    # else
    #     puts "English ..."
    #     @keyword = @keyword.downcase.capitalize.strip
    # end
    @search.keyword = @keyword
    @search.save
    
    if Search.where(keyword: @keyword).size > 1
        @search = Search.find_by(keyword: @keyword)
        @search.save
    else
        puts "start scraping..."
        # @search = Search.create!(keyword: @keyword)
        # @search.keyword = @keyword
        scraper(@search)
        GetKeywordsJob.perform_later(@search.id)
    end
  end
  
  def scraper(search)
    puts search
    @search = search
    jobs = []
    page = 1
    total_page = nil

    loop do 
        url = "https://search.51job.com/list/000000,000000,0000,00,9,99,#{@search.keyword},2,#{page}.html?lang=c&stype=&postchannel=0000&workyear=99&cotype=99&degreefrom=99&jobterm=99&companysize=99&providesalary=99&lonlat=0%2C0&radius=-1&ord_field=0&confirmdate=9&fromType=&dibiaoid=0&address=&line=&specialarea=00&from=&welfare="
        url = URI.parse(URI.escape(url)) # 避免輸入中文錯誤: URI must be ascii only
        html_data = open(url).read
        nokogiri_object = Nokogiri::HTML(html_data, nil, 'GBK') # encode: GBK!
        if total_page.nil?
            total_page = nokogiri_object.css("div.p_in > span.td").text.match('\d')[0].to_i
        end

        titles = nokogiri_object.css("div.el > p.t1 > span > a").map { |element| element['title'] }
        title_links = nokogiri_object.css("div.el > p.t1 > span > a").map { |element| element['href'] }
        companys = nokogiri_object.css("div.el > span.t2").map { |element| element.text }
        company_links = nokogiri_object.css("div.el > span.t2 > a").map { |element| element['href'] }
        locations = nokogiri_object.css("div.el > span.t3").map { |element| element.text }
        salaries = nokogiri_object.css("div.el > span.t4").map { |element| element.text }
        dates = nokogiri_object.css("div.el > span.t5").map { |element| element.text }

        (0...titles.size).each do |i|
            job = {name: titles[i], url: title_links[i], company: companys[i+1], location: locations[i+1], salary: salary_converter(salaries[i+1]), search_id: @search[:id], keyword: @search[:keyword]}
            @job = Job.new(job)
            @search.jobs << @job
        end
        page < total_page ? page += 1 : break
    end
end

def salary_converter(salary)
  return nil if salary.empty?
  value_s = salary.match('(\d?|\S?)*\B')[0]
  unit_s = salary.sub(value_s, "")
  value = value_s.split("-").map {|item| item.to_f}
  if unit_s == '万/月'
      unit = 10000
  elsif unit_s == '千/月' 
      unit = 1000
  elsif unit_s == '万/年'
      unit = 10000 / 12
  elsif unit_s == '元/天'
      unit = 30
  else 
      return nil
  end
  salary = (value.sum / value.size * unit).round(2) # RMB / month"
end

def get_average_salary(jobs)
  #caculate average salary
  unless jobs.empty?
      salaries = jobs.map { |job| job[:salary] }.select { |salary| !salary.nil? }
      average = (salaries.sum / salaries.size).round(2)
  end
end
end
