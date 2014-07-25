class NovelsController < ApplicationController
  def list
    @novels = Novel.all.updated_by
  end

  def add
  end

  def create
  end

  def edit
  end

  def update
  end
end

