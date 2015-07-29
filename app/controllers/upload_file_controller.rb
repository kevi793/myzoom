class UploadFileController < ApplicationController
  def import
    debugger
    UploadFile.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end

  def index

  end

end
