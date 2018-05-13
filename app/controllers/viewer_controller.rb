class ViewerController < ApplicationController
  def novels
    @novels = Novel.all
  end

  def top_chapters
    @chapters = current_novel.children
  end

  def chapters
    @chapters = current_chapter.children
    @chapter = current_chapter

    if @chapters.blank?
      @stories = Story.where(chapter_id: params[:chapter_id])
      render :stories
    end
  end

  def show
    @story = Story.find(params[:story_id])
    @stories = @story.brothers
  end
end
