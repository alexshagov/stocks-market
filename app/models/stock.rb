class Stock < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :bearer
end
