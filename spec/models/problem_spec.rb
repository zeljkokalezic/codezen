require 'rails_helper'

RSpec.describe Problem, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:language) }

  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:setup) }
  it { should validate_presence_of(:function_name) }
  it { should validate_presence_of(:test_cases) }
end
