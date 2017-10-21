class Language < ApplicationRecord
  validates :descriptor, :service_url, presence: true

  has_many :problems, dependent: :destroy
end
