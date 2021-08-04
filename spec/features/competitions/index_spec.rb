require "rails_helper"

RSpec.describe 'the competition index' do
  before(:each) do
    @competition_1 = Competition.create!(name: 'Basketball Tournament', location: 'Oregon', sport: 'Basketball')
    @competition_2 = Competition.create!(name: 'Football Tournament', location: 'Michigan', sport: 'Football')
    @competition_3 = Competition.create!(name: 'Baseball Tournament', location: 'Colorado', sport: 'Baseball')
  end

  describe 'display' do
    it 'lists the names of all competitions' do
      visit competitions_path

      within("#header") do
        expect(page).to have_content("Competitions Overview")
      end

      within("#competition-#{@competition_1.id}") do
        expect(page).to have_link("#{@competition_1.name}")
      end

      within("#competition-#{@competition_2.id}") do
        expect(page).to have_link("#{@competition_2.name}")
      end

      within("#competition-#{@competition_3.id}") do
        expect(page).to have_link("#{@competition_3.name}")
      end
    end
  end

  describe 'hyperlinks' do
    it 'links to show page for each competition link' do
      visit competitions_path

      within("#competition-#{@competition_1.id}") do
        click_link("#{@competition_1.name}")

        expect(current_path).to eq(competition_path(@competition_1.id))
      end

      visit competitions_path

      within("#competition-#{@competition_2.id}") do
        click_link("#{@competition_2.name}")

        expect(current_path).to eq(competition_path(@competition_2.id))
      end

      visit competitions_path

      within("#competition-#{@competition_3.id}") do
        click_link("#{@competition_3.name}")

        expect(current_path).to eq(competition_path(@competition_3.id))
      end
    end
  end
end
