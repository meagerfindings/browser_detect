# frozen_string_literal: true

class PortalsController < ApplicationController
  before_action :require_employee_user, only: %i[index show new create update edit destroy]

  def index
    @portals = Portal.all
    @page_title = 'All Browsers'
  end

  def new
    @portal = Portal.new
    @page_title = 'New Browser'
  end

  def show
    @portal = Portal.find(params[:id])
    @page_title = "#{@portal.name} Details"
  end

  def edit
    @portal = Portal.find(params[:id])
    @page_title = "Edit #{@portal.name}"
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
