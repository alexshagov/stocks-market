require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should belong_to(:bearer) }
end
