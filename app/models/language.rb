class Language < ApplicationRecord
  validates :descriptor, :service_url, :auth_token, presence: true

  has_many :problems, dependent: :destroy
end
