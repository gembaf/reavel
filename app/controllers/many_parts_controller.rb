class ManyPartsController < ApplicationController
  def list
    redirect_to parts_list_path
  end

  def add
    @chapter = Chapter.new
    @chapter.build_parts
  end

  def create
    results = []
    parts_params.each do |val|
      break if Common.skip?(val)
      val[:chapter_id] = params[:cid]
      results << Part.create(val)
    end

    is_success = Common.many_create_success?(results)
    redirect_to Common.list_path(is_success)
  end

  def edit
    @chapter = Chapter.where(id: params[:cid]).first
  end

  def update
    results = []
    parts_params.each do |val|
      part = Part.where(id: val[:id]).first
      val.delete(:id)
      results << part.update_attributes(val)
    end

    redirect_to Common.list_path(results.all?)
  end

  private
  def parts_params
    params.require(:chapter).require(:parts_attributes).values
  end
end

