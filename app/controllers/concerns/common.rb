module Common
  def list_path(is_success)
    url = {action: :list}
    url[:error] = true unless is_success
    url
  end

  def create_success?(result)
    !result.id.nil?
  end

  def error?(val)
    !val.nil?
  end

  module_function :list_path, :create_success?, :error?
end

