encoding=UTF-8
Dashboard.all.each do |i|
    if i.high_freq_en.nil? || i.high_freq_zh.nil?
        GetKeywordsJob.perform_later(i.id)
    end
end

