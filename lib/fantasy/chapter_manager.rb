require 'zip'

module Fantasy
  class ChapterManager
    attr_reader :dir_path

    def initialize(zip_file)
      @zip_file = zip_file
    end

    def unzip
      @dir_path = Rails.root.join('tmp', SecureRandom.uuid)

      ::Zip::File.open(@zip_file) do |zip|
        zip.each do |entry|
          next if entry.name =~ /^__MACOSX/
          output = "#{@dir_path}/#{entry.name.sub(%r{^(.*?)/}, '')}"
          zip.extract(entry, output) { true }
        end
      end
    end
  end
end
