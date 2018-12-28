class Dashboard < ApplicationRecord
    serialize :hot_skills
    has_many :jobs
end
