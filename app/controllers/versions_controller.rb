class VersionsController < ApplicationController
  def create
    @portal = Portal.find(params[:portal_id])
    @portal.versions.create(version_params)
    redirect_to portal_path(@portal)
  end

  def destroy
    @portal = Portal.find(params[:portal_id])
    @version = @portal.versions.find(params[:id])
    @version.destroy
    redirect_to portal_path(@portal)
  end

  private

  def version_params
    params.require(:version).permit(:number)
  end
end
