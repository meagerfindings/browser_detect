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
      render :show
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

  private

  def issue_params
    params.require(:issue).permit(:name, :description)
  end
end
