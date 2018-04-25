# frozen_string_literal: true

class VisitorsController < ApplicationController
  def index
    @visitors = Visitor.all
    @page_title = 'All Visitors'
  end

  def new
    @visitor = Visitor.new
    @page_title = 'New Visitor'
  end

  def show
    @visitor = Visitor.find(params[:id])
    @page_title = 'Visitor Details'
  end

  def edit
    @visitor = Visitor.find(params[:id])
    @page_title = 'Edit Visitor'
  end

  def create
    browser_attributes = Visitor.add_attributes(request.user_agent)

    params[:visitor]&.merge!(browser_attributes)

    @visitor = Visitor.new(visitor_params)

    if @visitor.save
      VisitorMailer.with(visitor: @visitor).share_information_email.deliver_later
      redirect_to @visitor
    else
      render 'new'
    end
  end

  def update
    @visitor = Visitor.find(params[:id])

    if @visitor.update(visitor_params)
      redirect_to @visitor
    else
      render 'edit'
    end
  end

  def destroy
    @visitor = Visitor.find(params[:id])
    @visitor.destroy

    redirect_to visitors_path
  end

  private

  def visitor_params
    params.require(:visitor).permit(:email, :browser, :version, :os, :comp_mode, :adblock, :css)
  end
end
