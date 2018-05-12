class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_novel
    return nil unless params[:novel_id]
    @current_novel ||= Novel.find(params[:novel_id])
  end

  def current_chapter
    return nil unless params[:chapter_id]
    @current_chapter ||= Chapter.find(params[:chapter_id])
  end
end
