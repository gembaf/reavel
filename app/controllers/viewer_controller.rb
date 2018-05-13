class ViewerController < ApplicationController
  def novels
    @novels = Novel.all
  end

  def chapters
    @chapters = if params[:chapter_id]
                  chapter = Chapter.find(params[:chapter_id])
                  chapter.children
                else
                  current_novel.children
                end

    if @chapters.blank?
      @stories = Story.where(chapter_id: params[:chapter_id])
      return render :stories
    end
  end

  def show
    @story = Story.find(params[:story_id])
  end
end
