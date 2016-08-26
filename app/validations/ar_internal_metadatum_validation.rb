module ArInternalMetadatumValidation
  extend ActiveSupport::Concern

  included do
    validates :key, presence: true
  end
end
