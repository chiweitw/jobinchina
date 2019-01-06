class Search < ApplicationRecord
    has_many :jobs
    validates :keyword, presence: true
    serialize :skills
    has_one :job_summary
end
