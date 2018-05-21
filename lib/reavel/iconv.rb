require 'iconv'

module Reavel
  module Iconv
    def read_and_split(path, code = 'shift-jis')
      encode(File.read(path)).split(/\r\n|\n/)
    end

    def encode(data, code = 'shift-jis')
      ::Iconv.conv('utf-8//ignore', code, data)
    end

    module_function :read_and_split, :encode
  end
end
