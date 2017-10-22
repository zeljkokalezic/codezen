class Problem < ApplicationRecord
  belongs_to :language
  belongs_to :user

  validates :text, :setup, :function_name, :test_cases, presence: true
  has_many :solutions, dependent: :destroy

  #TODO: test_case format validation
end
