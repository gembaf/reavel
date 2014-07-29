module ModelHelper
  def get_serial(val)
    val.nil? ? 1 : val.serial+1
  end

  module_function :get_serial
end

