require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:problems).dependent(:destroy) }
end
