require 'rails_helper'

RSpec.describe Language, type: :model do
  it { should have_many(:problems).dependent(:destroy) }

  it { should validate_presence_of(:descriptor) }
  it { should validate_presence_of(:service_url) }
end
