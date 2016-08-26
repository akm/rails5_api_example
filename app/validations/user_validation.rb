module UserValidation
  extend ActiveSupport::Concern

  included do
    validates :email, presence: true
    validates :access_token, presence: true
    validates :encrypted_password, presence: true
    validates :sign_in_count, presence: true, numericality: true
    validates_uniqueness_of :reset_password_token, allow_nil: true
    validates_uniqueness_of :access_token
    validates_uniqueness_of :email
  end
end
