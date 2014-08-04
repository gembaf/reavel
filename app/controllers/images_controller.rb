class ImagesController < ApplicationController
  def list
    @images = get_images
    @is_error = Common.error?(params[:error])
  end

  def add
    @image = Image.new
  end

  def create
    attr = image_params.merge(novel_id: params[:nid])
    contents = attr.delete(:contents)
    result = Image.create(attr)
    is_success = Common.create_success?(result)
    result.set_contents_info(contents) if is_success
    redirect_to Common.list_path(is_success)
  end

  def edit
    @image = Image.where(id: params[:iid]).first
  end

  def update
    attr = image_params
    contents = attr.delete(:contents)
    image = Image.where(id: params[:iid]).first
    is_success = image.update_attributes(attr)
    image.set_contents_info(contents) if is_success
    redirect_to Common.list_path(is_success)
  end

  def active
    image = Image.where(id: params[:iid]).first
    is_success = image.update_attributes(is_active: params[:is_active])
    redirect_to Common.list_path(is_success)
  end

  private
  def image_params
    params.require(:image).permit(:title, :contents)
  end

  def get_images
    Image.where(novel_id: params[:nid]).active_by.updated_by
  end
end
