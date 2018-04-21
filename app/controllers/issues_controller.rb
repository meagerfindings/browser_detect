class IssuesController < ApplicationController
  def index
    @version = Version.find(params[:version_id])
    @issue = @version.issues.all
  end

  def new
    @version = Version.find(params[:version_id])
    @issue = @version.issues.new
  end

  def edit
    @issue = Issue.find(params[:id])
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
