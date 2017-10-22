class Problem < ApplicationRecord
  belongs_to :language
  belongs_to :user

  validates :text, :setup, :function_name, :test_cases, presence: true

  #TODO: test_case format validation
end
