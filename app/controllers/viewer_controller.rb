class ViewerController < ApplicationController
  def novels
    @novels = Novel.all
  end
end
