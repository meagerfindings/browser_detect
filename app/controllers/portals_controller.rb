class PortalsController < ApplicationController
  def index
    @portals = Portal.all
  end

  def new
    @portal = Portal.new
  end

  def show
    @portal = Portal.find(params[:id])
  end

  def edit
    @portal = Portal.find(params[:id])
  end

  def create
    @portal = Portal.new(portal_params)

    if @portal.save
      redirect_to @portal
    else
      render 'new'
    end
  end

  def update
    @portal = Portal.find(params[:id])

    if @portal.update(portal_params)
      redirect_to @portal
    else
      render 'edit'
    end
  end

  def destroy
    @portal = Portal.find(params[:id])
    @portal.destroy

    redirect_to portals_path
  end

  private
  def portal_params
    params.require(:portal).permit(:name, :current)
  end
end