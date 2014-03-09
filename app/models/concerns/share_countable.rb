module ShareCountable
  extend ActiveSupport::Concern

  included do
    has_many :share_counts, as: :share_countable, dependent: :destroy

    def increment_shares(site_name)
      self.share_counts.create(:site_name => site_name)
    end
  end
end