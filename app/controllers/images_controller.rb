class ImagesController < ApplicationController
  before_action :get_image, only: [:edit, :update, :active]

  def list
    @images = Image.where(novel_id: params[:nid]).active_by
  end

  def add
    @image = Image.new
    render "add_edit"
  end

  def create
    attr = image_params.merge(novel_id: params[:nid])
    contents = attr.delete(:contents)
    image = Image.create(attr)
    image.set_contents_info(contents)
    redirect_to images_list_path
  end

  def edit
    render "add_edit"
  end

  def update
    attr = image_params.merge(novel_id: params[:nid])
    contents = attr.delete(:contents)
    @image.update_attributes(attr)
    @image.set_contents_info(contents)
    render "shared/reload"
  end

  def active
    @image.update(is_active: !@image.is_active)
    redirect_to images_list_path
  end

  private
  def image_params
    params.require(:image).permit(:title, :contents)
  end

  def get_image
    @image = Image.where(id: params[:iid]).first
  end
end

