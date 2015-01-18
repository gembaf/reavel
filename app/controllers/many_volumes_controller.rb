class ManyVolumesController < ApplicationController
  def add
    @part = Part.new
    @part.build_volumes
  end

  def create
    volumes_params.each do |val|
      break if Common.skip?(val)
      val[:part_id] = params[:pid]
      volume = Volume.new(val)
      volume.set_serial
      volume.save
    end
    redirect_to volumes_list_path
  end

  def edit
    @part = Part.where(id: params[:pid]).first
  end

  def update
    volumes_params.each do |val|
      volume = Volume.where(id: val[:id]).first
      val.delete(:id)
      volume.update_attributes(val)
    end
    redirect_to volumes_list_path
  end

  private
  def volumes_params
    params.require(:part).require(:volumes_attributes).values
  end
end

