class PagesController < ApplicationController
  def home
    @job_qty = Job.all.size
    @search_qty = Search.all.size
    rank_data = rank_data
    @search_rank = search_ranking.first(10)
    @chance_rank = location_chance_rank.first(10)
    @job_salary_rank = salary_ranking.first(10)
    @location_salary_rank = location_salary.first(10)
  end

  private

  def search_ranking
    search_ranking = {}
    searches = Dashboard.all
    searches.each do |search|
        keyword = search[:keyword]
        search_ranking[keyword] = search.searched_times
    end
    search_ranking = search_ranking.sort_by{|k, v| v}.reverse.to_a 
  end

  def location_chance_rank
    location_qty = {}
    jobs = Job.all
    jobs.each do |job|
      location = job[:location].split("-").first
      if location_qty[location].nil?
          location_qty[location] = 1
      else 
          location_qty[location] += 1
      end
    end
    location_qty.sort_by{|k, v| v}.reverse.to_a.first(10)
  end


  def salary_ranking
      salary_ranking = {}
      searches = Search.all
      searches.each do |search|
          salary_ranking[search[:keyword]] = search[:average_salary] || 0
      end
      salary_ranking = salary_ranking.sort_by{|k, v| v}.reverse.to_a 
  end

  def location_salary
    jobs = Job.all
    location_salary = {}
    jobs.each do |job|
        unless job[:salary].nil?
            location = job[:location].split("-").first
            if location_salary[location].nil?
                location_salary[location] = [job[:salary]]
            else 
                location_salary[location] << job[:salary]
            end
        end
    end
    location_salary.select{|k,v| v.size > 3 }.map {|k, v|[k, (v.sum/v.size).round(2)]}.sort_by {|k,v| v}.reverse
    # need at least 3 data per location
end
end