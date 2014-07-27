module Common
  def list_path(is_success, id = nil)
    url = {action: :list, id: id}
    url[:error] = true unless is_success
    url
  end

  def create_success?(result)
    !result.id.nil?
  end

  def error?(val)
    !val.nil?
  end

  def select_format(base)
    base.active.map do |val|
      [val.title, val.id]
    end
  end

  module_function :list_path, :create_success?, :error?, :select_format
end

