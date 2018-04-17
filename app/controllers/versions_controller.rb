class VersionsController < ApplicationController
  def index
    @portal = Portal.find(params[:portal_id])
    @version = @portal.versions.all
  end

  def new
    @portal = Portal.find(params[:portal_id])
    @version = @portal.versions.build
  end

  def edit
    @version = Version.find(params[:id])
  end

  def create
    @portal = Portal.find(params[:portal_id])
    @version = @portal.versions.new(version_params)

    if @version.save
      redirect_to portal_path(@portal)
    else
      render action: :new
    end
  end

  def show
    @version = Version.find(params[:id])
  end

  def update
    @version = Version.find(params[:id])

    if @version.update(version_params)
      redirect_to @version
    else
      render 'edit'
    end
  end

  def destroy
    # @portal = Portal.find(params[:portal_id])
    @version = Version.find(params[:id])
    saved_portal_path = @version.portal_id
    @version.destroy
    redirect_to portal_path(saved_portal_path)
  end

  private

  def version_params
    params.require(:version).permit(:number)
  end
end
