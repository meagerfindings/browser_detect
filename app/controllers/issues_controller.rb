class IssuesController < ApplicationController
  def index
    @version = Version.find(params[:version_id])
    @issue = @version.issues.all
    @page_title = "#{@version.portal.name.titleize} #{@version.number} Issues"
  end

  def new
    @version = Version.find(params[:version_id])
    @issue = @version.issues.new
    @page_title = "New #{@issue.name.titleize}"
  end

  def edit
    @issue = Issue.find(params[:id])
    @page_title = "Edit Issue #{@issue.name.titleize}"
  end

  def create
    @version = Version.find(params[:version_id])
    @issue = @version.issues.new(issue_params)

    if @issue.save
      redirect_to issue_path(@issue)
    else
      render :new
    end
  end

  def show
    @issue = Issue.find(params[:id])
    @page_title = "Issue #{@issue.name.titleize} Details"
  end

  def update
    @issue = Issue.find(params[:id])

    if @issue.update(issue_params)
      redirect_to @issue
    else
      render 'edit'
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    saved_version_path = @issue.version_id
    @issue.destroy
    redirect_to version_issues_path(saved_version_path)
  end

  private

  def issue_params
    params.require(:issue).permit(:name, :description)
  end
end
