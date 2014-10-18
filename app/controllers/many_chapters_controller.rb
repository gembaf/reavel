class ManyChaptersController < ApplicationController
  def add
    @novel = Novel.new
    @novel.build_chapters
  end

  def create
    chapters_params.each do |val|
      break if Common.skip?(val)
      val[:novel_id] = params[:nid]
      Chapter.create(val)
    end
    redirect_to chapters_list_path
  end

  def edit
    @novel = Novel.where(id: params[:nid]).first
  end

  def update
    chapters_params.each do |val|
      chapter = Chapter.where(id: val[:id]).first
      val.delete(:id)
      chapter.update_attributes(val)
    end
    redirect_to chapters_list_path
  end

  private
  def chapters_params
    params.require(:novel).require(:chapters_attributes).values
  end
end

