module PostValidation
  extend ActiveSupport::Concern

  included do
    validates :user_id, presence: true, numericality: true
    validates :title, presence: true
    validates :rating, numericality: true, allow_nil: true
  end
end
