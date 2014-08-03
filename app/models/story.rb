class Story < ActiveRecord::Base
  belongs_to :volume

  validates :volume_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.active_by(self)

  READ_CHARA_PER_SEC = 500

  def self.scene_format
    {
      "あり" => true,
      "なし" => false
    }
  end

  def self.file_path(id)
    "#{Rails.root}/public/novels/contents/%05d.mkd" % id
  end

  def ids
    stories = Story.where(volume_id: self.volume_id).active.serial_by
    prev_id = next_id = nil

    stories.each_with_index do |story, i|
      break if stories[i+1].nil?
      prev_id = story.id if stories[i+1].id == self.id
      next_id = stories[i+1].id if story.id == self.id
    end
    [prev_id, next_id]
  end

  def set_contents_info(contents_params)
    contents = Story.file_path(self.id)
    text = contents_params[:text]
    text = contents_params[:file].read unless contents_params[:file].blank?
    File.open(contents, 'w') { |f| f.puts text.force_encoding("UTF-8") }
    self.update_attributes(contents: contents, time: get_time(text))
  end

  # override
  def self.create(params)
    story = self.where(volume_id: params[:volume_id]).last
    params[:serial] = ModelHelper.get_serial(story)
    super params
  end

  private
  def get_time(text)
    text.gsub(/<.*?>/, "").gsub(/\r\n|\n/, "").size / READ_CHARA_PER_SEC
  end
end

