class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.where(user_id: current_user.id)
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    if @game.save
      redirect_to games_path, notice: "Game created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    if current_user.id == @game.user_id
      if @game.update(game_params)
        redirect_to games_path, notice: "Game updated successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "You are not authorized to edit this game."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.id == @game.user_id
      Game.find(params[:id]).destroy
    else
      flash.now[:alert] = "You are not authorized to delete this game."
      # render :edit, status: :unprocessable_entity
      redirect_back(fallback_location: games_path)
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :description, :user_id, :shareable, :public, :status)
  end

end
