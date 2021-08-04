class CompetitionTeamsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
  end

  def create
    competition = Competition.find(params[:competition_id])
    competition.teams.create(competition_team_params)
    redirect_to competition_path(competition.id)
  end

  private

  def competition_team_params
    params.permit(:hometown, :nickname)
  end
end
