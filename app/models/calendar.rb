class Calendar < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :slots, dependent: :destroy 
end
