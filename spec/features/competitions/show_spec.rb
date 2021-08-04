require "rails_helper"

RSpec.describe 'the competition show' do
  before(:each) do
    @competition_1 = Competition.create!(name: 'Basketball Tournament', location: 'Oregon', sport: 'Basketball')
    @competition_2 = Competition.create!(name: 'Football Tournament', location: 'Michigan', sport: 'Football')

    @team_1 = @competition_1.teams.create!(hometown: 'La Grande', nickname: 'fun times')
    @team_2 = @competition_1.teams.create!(hometown: 'Detroit', nickname: 'winners')
    @team_3 = @competition_1.teams.create!(hometown: 'Denver', nickname: 'climbers')

    @team_4 = @competition_2.teams.create!(hometown: 'Colorado Springs', nickname: 'thunder')

    @player_1 = @team_1.players.create!(name: 'Dame', age: 30)
    @player_2 = @team_1.players.create!(name: 'CJ', age: 30)
    @player_3 = @team_1.players.create!(name: 'Nurk', age: 28)

    @player_4 = @team_2.players.create!(name: 'LeBron', age: 35)
    @player_5 = @team_2.players.create!(name: 'MJ', age: 45)
    @player_6 = @team_2.players.create!(name: 'Shaq', age: 40)

    @player_7 = @team_3.players.create!(name: 'Steph', age: 32)
    @player_8 = @team_3.players.create!(name: 'Klay', age: 30)
    @player_9 = @team_3.players.create!(name: 'Green', age: 29)
  end

  describe 'display' do
    it 'shows competiton name, location, sport, and average player age' do
      visit competition_path(@competition_1.id)

      within("#header") do
        expect(page).to have_content("#{@competition_1.name}")
        expect(page).to_not have_content("#{@competition_2.name}")
      end

      within("#attributes") do
        expect(page).to have_content("Location: #{@competition_1.location}")
        expect(page).to have_content("Sport: #{@competition_1.sport}")
        expect(page).to have_content("Players Average Age: #{@competition_1.players.average_age}")

        expect(page).to_not have_content("Location: #{@competition_2.location}")
        expect(page).to_not have_content("Sport: #{@competition_2.sport}")
      end
    end

    it 'shows team nicknames and hometowns and link to add a team' do
      visit competition_path(@competition_1.id)

      within("#teams") do
        expect(page).to have_content("Teams:")
        expect(page).to have_button("Register a new team")
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

  describe 'create a new team' do
    it 'links to form to create new team that adds team to competion when submitted' do
      visit competition_path(@competition_1.id)

      within("#teams") do
        click_button("Register a new team")
      end

      expect(page).to have_content("Register new team for #{@competition_1.name}")

      fill_in 'Hometown', with: 'New Hometown'
      fill_in 'Nickname', with: 'New Nickname'
      click_button 'Submit'

      expect(current_path).to eq(competition_path(@competition_1.id))

      within("#teams") do
        expect(page).to have_content("Team 4")
        expect(page).to have_content("Nickname: New Nickname")
        expect(page).to have_content("Hometown: New Hometown")
      end
    end
  end
end
