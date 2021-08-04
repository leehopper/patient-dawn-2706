class Competition < ApplicationRecord
  has_many :entrants
  has_many :teams, through: :entrants
end
