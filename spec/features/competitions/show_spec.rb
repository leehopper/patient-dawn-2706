require "rails_helper"

RSpec.describe 'the competition show' do
  before(:each) do
    @competition_1 = Competition.create!(name: 'Basketball Tournament', location: 'Oregon', sport: 'Basketball')
    @competition_2 = Competition.create!(name: 'Football Tournament', location: 'Michigan', sport: 'Football')

    @team_1 = @competition_1.teams.create!(hometown: 'La Grande', nickname: 'fun times')
    @team_2 = @competition_1.teams.create!(hometown: 'Detroit', nickname: 'winners')
    @team_3 = @competition_1.teams.create!(hometown: 'Denver', nickname: 'climbers')

    @team_4 = @competition_2.teams.create!(hometown: 'Colorado Springs', nickname: 'thunder')
  end

  describe 'display' do
    it 'shows competiton name, location, and sport' do
      visit competition_path(@competition_1.id)

      within("#header") do
        expect(page).to have_content("#{@competition_1.name}")
        expect(page).to_not have_content("#{@competition_2.name}")
      end

      within("#attributes") do
        expect(page).to have_content("Location: #{@competition_1.location}")
        expect(page).to have_content("Sport: #{@competition_1.sport}")

        expect(page).to_not have_content("Location: #{@competition_2.location}")
        expect(page).to_not have_content("Sport: #{@competition_2.sport}")
      end
    end

    it 'shows team nicknames and hometowns' do
      visit competition_path(@competition_1.id)

      within("#teams") do
        expect(page).to have_content("Teams:")
        expect(page).to_not have_content("#{@team_4.nickname}")
        expect(page).to_not have_content("#{@team_4.hometown}")

        within("#team-#{@team_1.id}") do
          expect(page).to have_content("Team 1")
          expect(page).to have_content("Nickname: #{@team_1.nickname}")
          expect(page).to have_content("Hometown: #{@team_1.hometown}")
        end

        within("#team-#{@team_2.id}") do
          expect(page).to have_content("Team 2")
          expect(page).to have_content("Nickname: #{@team_2.nickname}")
          expect(page).to have_content("Hometown: #{@team_2.hometown}")
        end

        within("#team-#{@team_3.id}") do
          expect(page).to have_content("Team 3")
          expect(page).to have_content("Nickname: #{@team_3.nickname}")
          expect(page).to have_content("Hometown: #{@team_3.hometown}")
        end
      end
    end
  end
end
