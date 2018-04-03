class VisitorsController < ApplicationController
  def index
    @visitors = Visitor.all
  end

  def new
    @visitor = Visitor.new
  end

  def show
    @visitor = Visitor.find(params[:id])
  end

  def edit
    @visitor = Visitor.find(params[:id])
  end

  def create
    browser_attributes = Visitor.add_attributes(request.user_agent)

    params[:visitor].merge!(browser_attributes)

    @visitor = Visitor.new(visitor_params)

    if @visitor.save
      redirect_to @visitor
    else
      render 'new'
    end
  end

  private

  def visitor_params
    params.require(:visitor).permit(:email, :browser, :version, :os, :comp_mode)
  end
end
