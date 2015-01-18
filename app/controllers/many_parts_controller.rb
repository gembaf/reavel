class ManyPartsController < ApplicationController
  def add
    @chapter = Chapter.new
    @chapter.build_parts
  end

  def create
    parts_params.each do |val|
      break if Common.skip?(val)
      val[:chapter_id] = params[:cid]
      part = Part.new(val)
      part.set_serial
      part.save
    end
    redirect_to parts_list_path
  end

  def edit
    @chapter = Chapter.where(id: params[:cid]).first
  end

  def update
    parts_params.each do |val|
      part = Part.where(id: val[:id]).first
      val.delete(:id)
      part.update_attributes(val)
    end
    redirect_to parts_list_path
  end

  private
  def parts_params
    params.require(:chapter).require(:parts_attributes).values
  end
end

