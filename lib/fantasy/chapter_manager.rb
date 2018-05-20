require 'zip'

module Fantasy
  class ChapterManager
    IGNORE = %w(FORE_00.txt FORE_99_01.txt FORE_99_02.txt)

    attr_reader :dir_path

    def initialize(zip_file)
      @zip_file = zip_file
    end

    def chapter_list_file
      files.select { |name| name =~ /\.txt$/ }.first
    end

    def mht_files
      files.select { |name| name =~ /\.mht$/ }
    end

    def unzip
      return if @dir_path.present?

      @dir_path = Rails.root.join('tmp', SecureRandom.uuid)

      ::Zip::File.open(@zip_file) do |zip|
        zip.each do |entry|
          next if entry.name =~ /^__MACOSX/
          output = "#{@dir_path}/#{entry.name.sub(%r{^(.*?)/}, '')}"
          zip.extract(entry, output) { true }
        end
      end
    end

    private

    def files
      unzip
      `ls #{@dir_path}`.split(/\n/).reject { |name| IGNORE.include?(name) }
    end
  end
end
