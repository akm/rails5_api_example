module UserValidation
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates_uniqueness_of :token, allow_nil: true
  end
end
