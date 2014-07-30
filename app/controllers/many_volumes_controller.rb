class ManyVolumesController < ApplicationController
  def list
    redirect_to volumes_list_path
  end

  def add
    @part = Part.new
    @part.build_volumes
  end

  def create
    results = []
    volumes_params.each do |val|
      break if Common.skip?(val)
      val[:part_id] = params[:pid]
      results << Volume.create(val)
    end

    is_success = Common.many_create_success?(results)
    redirect_to Common.list_path(is_success)
  end

  def edit
    @part = Part.where(id: params[:pid]).first
  end

  def update
    results = []
    volumes_params.each do |val|
      volume = Volume.where(id: val[:id]).first
      val.delete(:id)
      results << volume.update_attributes(val)
    end

    redirect_to Common.list_path(results.all?)
  end

  private
  def volumes_params
    params.require(:part).require(:volumes_attributes).values
  end
end

