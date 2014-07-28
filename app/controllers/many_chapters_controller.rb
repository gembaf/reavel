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
    params.require(:novel).require(:chapters_attributes).each do |_, val|
      break if Common.skip?(val)
      val[:novel_id] = params[:nid]
      results << Chapter.create(val)
    end

    is_success = Common.many_create_success?(results)
    redirect_to Common.list_path(is_success)
  end

  def edit
    @novel = Novel.where(id: params[:nid]).first
    @novel.chapters = @novel.chapters.active
  end

  def update
    render text: params
  end
end

