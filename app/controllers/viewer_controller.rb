class ViewerController < ApplicationController
  before_action :assign, only: %i[top_chapters chapters show]

  def novels
    @novels = Novel.all
  end

  def top_chapters
    @chapters = current_novel.children
  end

  def chapters
    @chapters = current_chapter.children

    if @chapters.blank?
      @stories = Story.where(chapter_id: params[:chapter_id])
      render :stories
    end
  end

  def show
  end

  private

  def assign
    @novel = current_novel
    @chapter = current_chapter
    @story = current_story
  end
end
