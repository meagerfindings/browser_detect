class VersionsController < ApplicationController
  def index
    @portal = Portal.find(params[:portal_id])
    @version = @portal.versions.all
    @page_title = "#{@portal.name} Versions"
  end

  def new
    @portal = Portal.find(params[:portal_id])
    @version = @portal.versions.build
    @page_title = "New #{@portal.name} Version"
  end

  def edit
    @version = Version.find(params[:id])
    @page_title = "Edit #{@version.portal.name} #{@version.number}"
  end

  def create
    @portal = Portal.find(params[:portal_id])
    @version = @portal.versions.new(version_params)

    if @version.save
      redirect_to version_path(@version)
    else
      render action: :new
    end
  end

  def show
    @version = Version.find(params[:id])
    @page_title = "#{@version.portal.name} #{@version.number} Details"
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
    @version = Version.find(params[:id])
    saved_portal_path = @version.portal_id
    @version.destroy

    if request.path == "/versions/#{@version.id}"
      redirect_to portal_versions_path(saved_portal_path)
    else
      redirect_to portal_path(saved_portal_path)
    end
  end

  private

  def version_params
    params.require(:version).permit(:number)
  end
end
