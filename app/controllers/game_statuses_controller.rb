class GameStatusesController < ApplicationController
  before_action :authenticate_user!

  def index
    @game_statuses = GameStatus.where(game_mgr_id: current_user.id)
  end
end
