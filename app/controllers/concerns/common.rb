module Common
  def list_path(is_success)
    url = {action: :list}
    url[:error] = true unless is_success
    url
  end

  def create_success?(result)
    !result.id.nil?
  end

  def many_create_success?(results)
    results.all? {|r| !r.id.nil?}
  end

  def error?(val)
    !val.nil?
  end

  def select_format(base)
    base.active.map do |val|
      [val.title, val.id]
    end
  end

  def skip?(val)
    val[:title] == "notitle" && val[:comment].empty?
  end

  module_function :list_path, :create_success?, :many_create_success?, :error?, :select_format, :skip?
end

