# frozen_string_literal: true

class PortalIssuesController < ApplicationController
  before_action :require_employee_user, only: %i[index show new create update edit destroy]

  def index
    @portal = Portal.find(params[:portal_id])
    @portal_issues = @portal.portal_issues.all
    @page_title = "#{@portal.name.titleize} Issues"
  end

  def new
    @portal = Portal.find(params[:portal_id])
    @portal_issue = @portal.portal_issues.new
    @page_title = 'New Browser Issue'
  end

  def edit
    @portal_issue = PortalIssue.find(params[:id])
    @page_title = "Edit Issue #{@portal_issue.name.titleize}"
  end

  def create
    @portal = Portal.find(params[:portal_id])
    @portal_issue = @portal.portal_issues.new(issue_params)

    if @portal_issue.save
      redirect_to portal_portal_issues_path(@portal)
    else
      render :new
    end
  end

  def show
    @portal_issue = PortalIssue.find(params[:id])
    @page_title = "Issue #{@portal_issue.name.titleize} Details"
  end

  def update
    @portal_issue = PortalIssue.find(params[:id])

    if @portal_issue.update(issue_params)
      redirect_to @portal_issue
    else
      render 'edit'
    end
  end

  def destroy
    @portal_issue = PortalIssue.find(params[:id])
    saved_portal_path = @portal_issue.portal_id
    @portal_issue.destroy
    redirect_to portal_portal_issues_path(saved_portal_path)
  end

  private

  def issue_params
    params.require(:portal_issue).permit(:name, :description)
  end
end
