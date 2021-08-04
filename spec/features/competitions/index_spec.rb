require "rails_helper"

RSpec.describe 'the competition index' do
  before(:each) do
    @competition_1 = Competition.create!(name: 'Basketball Tournament', location: 'Oregon', sport: 'Basketball')
    @competition_2 = Competition.create!(name: 'Football Tournament', location: 'Michigan', sport: 'Football')
    @competition_3 = Competition.create!(name: 'Baseball Tournament', location: 'Colorado', sport: 'Baseball')
  end

  describe 'display' do
    it 'lists the names of all competitions' do
      visit "/competitions"
    end
  end
end
