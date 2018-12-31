class PagesController < ApplicationController
  def home
    @search_qty = Dashboard.all.map{|i|i.searched_times}.inject(0){|sum,x| sum + x }
    @search_rank = search_ranking.first(10)
    @chance_rank = location_chance_rank.first(10)
    @job_salary_rank = salary_ranking.first(10)
    @location_salary_rank = location_salary.first(10)
  end

  def letsencrypt
    # use your code here, not mine
    render plain: "d0RJoQgaNstdyzd8FUOTuB82zgOuOA4Nl8tDE6BnnSk.jPKhr5tqUwBULRkJDZephsvpu7KXblmbCr9GUMIXsww"
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
    jobSummaries = JobSummary.all
    jobSummaries.each do |job_summary|
        location_qty = location_qty.merge(job_summary[:location_qty].to_h){|key, oldval, newval| newval.to_i + oldval.to_i}
    end

    location_qty.sort_by{|k, v| v.to_i}.reverse.to_a.first(10)
  end

  def salary_ranking
      salary_ranking = {}
      searches = Dashboard.where("job_qty > 10")
      searches.each do |search|
          salary_ranking[search[:keyword]] = search[:average_salary] || 0
      end
      salary_ranking = salary_ranking.sort_by{|k, v| v}.reverse.to_a 
  end

  def location_salary

    jobSummaries = JobSummary.all

    location_qty = {}
    jobSummaries.each do |job_summary|
        location_qty = location_qty.merge(job_summary[:location_qty].to_h){|key, oldval, newval| newval.to_i + oldval.to_i}
    end

    location_salary_sum = {}
    jobSummaries.each do |job_summary|   
        location_salary_sum_element = job_summary[:location_qty].map{|k,v| [k , v.to_i * job_summary[:location_salary].to_h[k].to_f]}.to_h
        location_salary_sum = location_salary_sum.merge(location_salary_sum_element){|key, oldval, newval| newval.to_f + oldval.to_f}
    end
    
    location_salary = location_salary_sum.map{|k,v| [k,v.to_f / location_qty[k].to_i ] }.sort_by {|k,v| v}.reverse
  end
end

