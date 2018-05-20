require 'iconv'

module Reavel
  module Iconv
    def read_and_split(path, code = 'shift-jis')
      ::Iconv.conv('utf-8', code, File.read(path)).split(/\r\n|\n/)
    end

    module_function :read_and_split
  end
end
