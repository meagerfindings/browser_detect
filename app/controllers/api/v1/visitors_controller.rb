class Api::V1::VisitorsController < ApplicationController
  def index
    render json: Visitor.all
  end

  def show
    render json: Visitor.find(params[:id])
  end

  def create
    render json: Visitor.create(visitor_params)
  end

  def update
    render json: Visitor.update(params[:id], visitor_params)
  end

  def destroy
    render json: Visitor.destroy(params[:id])
  end

  private

  def visitor_params
    params.require(:visitor).permit(:adblock, :email)
  end
end