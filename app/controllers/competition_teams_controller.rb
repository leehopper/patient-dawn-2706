class CompetitionTeamsController < ApplicationController
  def create
    @competition = Competition.find(params[:competition_id])
  end
end
