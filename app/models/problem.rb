class Problem < ApplicationRecord
  belongs_to :language
  belongs_to :user

  validates :text, :setup, :function_name, presence: true
end
