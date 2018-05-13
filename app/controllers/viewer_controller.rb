class ViewerController < ApplicationController
  def novels
    @novels = Novel.all
  end

  def top_chapters
    @chapters = current_novel.children
    render :chapters
  end

  def chapters
    chapter = Chapter.find(params[:chapter_id])
    @chapters = chapter.children

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
