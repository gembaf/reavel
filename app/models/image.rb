class Image < ActiveRecord::Base
  belongs_to :novel

  validates :novel_id, :title, presence: true
  validates :title, length: {maximum: 250}

  Scope.active_by(self)
  Scope.updated_by(self)

  def self.file_path(id, ext)
    "#{Rails.root}/public/novels/images/%04d.#{ext}" % id
  end

  def src_path
    self.contents.split("public").last
  end

  def set_contents_info(contents)
    return if contents.nil?
    ext = contents.original_filename.split(".").last
    fpath = Image.file_path(self.id, ext)
    File.open(fpath, "w") {|f| f.puts contents.read.force_encoding("UTF-8")}
    self.update_attributes(contents: fpath)
  end
end

