class CompetitionTeamsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
    @team = Team.new
  end

  def create
    binding.pry 
  end
end
