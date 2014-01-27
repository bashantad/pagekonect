module Viewable
  extend ActiveSupport::Concern

  included do
    has_many :views, as: :viewable, dependent: :destroy
  end
end