class ViewerController < ApplicationController
  def novels
    @novels = Novel.all
  end

  def chapters
    @parts = current_chapter ? current_chapter.children : current_novel&.children
    @parts ||= []
  end

  def stories
    @story = Story.find(params[:story_id])
  end
end
