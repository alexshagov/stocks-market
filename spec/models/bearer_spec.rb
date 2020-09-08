require 'rails_helper'

RSpec.describe Bearer, type: :model do
  it { should have_many(:stocks) }
end
