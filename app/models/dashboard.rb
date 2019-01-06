class Dashboard < ApplicationRecord
    serialize :high_freq_en
    serialize :high_freq_zh
    has_many :jobs

    extend FriendlyId
    friendly_id :keyword, use: :slugged

    def normalize_friendly_id(input)
        input.to_s.to_slug.normalize.to_s
    end
end
