class OrganizationsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def new
  end

  def create
  end
  
  def update
  end

  def destroy
    @organization = Organization.find(params[:id])
    if organization.owner_id == current_user.id
      @organization.destroy
      redirect_to root_path, notice: 'Organization was successfully destroyed.'
    else
      redirect_to root_path, alert: "You are not the owner of this organization"
    end
  end

end
