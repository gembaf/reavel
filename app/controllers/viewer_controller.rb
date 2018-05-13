class ViewerController < ApplicationController
  def novels
    @novels = Novel.all
  end

  def top_chapters
    @chapters = current_novel.children
    @parents = []
    render :chapters
  end

  def chapters
    chapter = Chapter.find(params[:chapter_id])
    @chapters = chapter.children
    @parents = current_novel.chapters.where(parent_id: chapter.parent_id)

    if @chapters.blank?
      @stories = Story.where(chapter_id: params[:chapter_id])
      render :stories
    end
  end

  def show
    @story = Story.find(params[:story_id])
    @stories = Story.where(chapter_id: @story.chapter_id)
  end
end
