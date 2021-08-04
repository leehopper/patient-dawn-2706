require 'rails_helper'

RSpec.describe Player do
  describe 'relationships' do
    it { should belong_to(:team) }
  end

  before(:each) do
    @team_1 = Team.create!(hometown: 'La Grande', nickname: 'fun times')
    @team_2 = Team.create!(hometown: 'Detroit', nickname: 'winners')

    @player_1 = @team_1.players.create!(name: 'Dame', age: 30)
    @player_2 = @team_1.players.create!(name: 'CJ', age: 30)
    @player_3 = @team_1.players.create!(name: 'Nurk', age: 28)

    @player_4 = @team_2.players.create!(name: 'LeBron', age: 35)
    @player_5 = @team_2.players.create!(name: 'MJ', age: 45)
    @player_6 = @team_2.players.create!(name: 'Shaq', age: 40)
  end

  describe 'class_methods' do
    describe '#average_age' do
      it 'returns the average age of all players' do
        expected = (@player_1.age + @player_2.age + @player_3.age + @player_4.age + @player_5.age + @player_6.age) / (@team_1.players.count + @team_2.players.count)

        expect(Player.average_age).to eq(expected)
      end
    end
  end
end
