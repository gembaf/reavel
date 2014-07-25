class NovelsController < ApplicationController
  def list
    @novels = Novel.all.updated_by
    @is_error = Common.error?(params[:error])
  end

  def add
    @novel = Novel.new
  end

  def create
    attr = params.require(:novel).permit(:title, :mode, :comment, :summary)
    result = Novel.create(attr)
    is_success = Common.create_success?(result)

    redirect_to Common.url(is_success)
  end

  def edit
  end

  def update
  end
end

