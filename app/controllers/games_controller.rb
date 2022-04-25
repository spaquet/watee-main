class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.where(user_id: current_user.id)
  end

  def new
    @game = Game.new
  end

  def create
    flash[:success] = "Game created!"
    redirect_to games_path
  end

  def edit
    @game = Game.find(params[:id])
  end

  def show
    @game = Game.find(params[:id])
  end

  def update

  end

  def destroy

  end

end
