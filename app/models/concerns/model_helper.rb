module ModelHelper
  def get_serial(val)
    val.nil? ? 1 : val.serial+1
  end

  def toggle_active(models, time, episode, is_active)
    models.each do |model|
      if true?(is_active)
        model.time += time
        model.episode += episode
      else
        model.time -= time
        model.episode -= episode
      end
      model.save
    end
  end

  def true?(flag)
    flag == "true" || flag == true
  end

  module_function :get_serial, :toggle_active, :true?
end

