class Dashboard < ApplicationRecord
    serialize :high_freq_en
    serialize :high_freq_zh
    has_many :jobs
end
