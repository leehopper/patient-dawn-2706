class Team < ApplicationRecord
  has_many :players
  has_many :entrants
  has_many :competitions, through: :entrants
end
