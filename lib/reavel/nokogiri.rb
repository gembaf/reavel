module Reavel
  module Nokogiri
    def parse(path)
      ::Nokogiri::HTML.parse(File.read(path), nil, 'utf-8')
    end

    module_function :parse
  end
end
