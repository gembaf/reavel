class ManyChaptersController < ApplicationController
  def list
    redirect_to chapters_list_path
  end

  def add
    @novel = Novel.new
    @novel.build_chapters
  end

  def create
    results = []
    chapters_params.each do |val|
      break if Common.skip?(val)
      val[:novel_id] = params[:nid]
      results << Chapter.create(val)
    end

    is_success = Common.many_create_success?(results)
    redirect_to Common.list_path(is_success)
  end

  def edit
    @novel = Novel.where(id: params[:nid]).first
  end

  def update
    results = []
    chapters_params.each do |val|
      chapter = Chapter.where(id: val[:id]).first
      val.delete(:id)
      results << chapter.update_attributes(val)
    end

    redirect_to Common.list_path(results.all?)
  end

  private
  def chapters_params
    params.require(:novel).require(:chapters_attributes).values
  end
end

