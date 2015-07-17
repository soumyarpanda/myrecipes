class Like < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  #We want at item to be liked only once
  validates_uniqueness_of :chef, scope: :recipe
end