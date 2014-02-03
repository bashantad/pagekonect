module Viewable
  extend ActiveSupport::Concern

  included do
    has_many :views, as: :viewable, dependent: :destroy

    def increment_views(ip)
      self.views.create(:ip_address => ip) if self.views.where(:ip_address => ip).blank?
    end
  end
end