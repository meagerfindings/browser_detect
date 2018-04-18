class IssuesController < ApplicationController
  def index
    @version = Version.find(params(:version_id))
    @issue = @version.issues.all
  end

  def new
    @version = Version.find(params(:version_id))
    @issue = @version.issues.build
  end

  def create
    @version = Version.find(params[:version_id])
    @issue = @version.issues.new(issue_params)
  end

  private

  def issue_params
    params.require(:issue).permit(:name, :description)
  end
end
