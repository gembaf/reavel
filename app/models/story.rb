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
    File.open(contents, 'w') { |f| f.puts text }
    time = get_time(File.read(contents))
    self.update_parents_time(time)
    self.update_attributes(contents: contents, time: time)
  end

  def toggle_active(params)
    ModelHelper.toggle_active(parents(self), self.time, 1, params[:is_active])
    self.update_attributes(params)
  end

  def update_parents_time(time)
    parents(self).each do |model|
      model.time += time - self.time
      model.save
    end
  end

  def update_parents_episode
    parents(self).each do |model|
      model.episode += 1
      model.save
    end
  end

  # override
  def self.create(params)
    story = self.where(volume_id: params[:volume_id]).last
    params[:serial] = ModelHelper.get_serial(story)
    super(params).tap {|s| s.update_parents_episode}
  end

  private
  def get_time(text)
    text.gsub(/<.*?>/, "").gsub(/\r\n|\n/, "").size / READ_CHARA_PER_SEC
  end

  def parents(story)
    volume = story.volume
    part = volume.part
    chapter = part.chapter
    novel = chapter.novel
    [volume, part, chapter, novel]
  end

  def encode_utf8(text)
    tmp_file = "#{Rails.root}/tmp/_tmp.mkd"
    File.open(tmp_file, "w") {|f| f.puts text.force_encoding("UTF-8")}
    `nkf --overwrite -w #{tmp_file}`
    File.read(tmp_file)
  end
end

