module ApplicationHelper
  def format_time(time)
    "約 #{time} 分"
  end

  def format_episode(episode)
    "全 #{episode} 話"
  end

  def format_title(title)
    "・ #{title}"
  end

  def markdown(contents)
    text = File.read(contents)
    text.gsub!(/\r\n\r\n|\n\n/, "\n<br />")
    unless @markdown
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(renderer)
    end
    @markdown.render(text).html_safe
  end

  def get_titles(ids)
    names = %w(chapters parts volumes stories)
    models = [Novel, Chapter, Part, Volume]
    titles = {}

    elem = ids.zip(names).zip(models).map {|e| e.flatten}
    elem.each do |id, name, model|
      next if id.nil?
      titles[name] = model.where(id: id).first.title
    end
    titles
  end

  def index_by(models)
    models.active.serial_by
  end

  def all_ids(sid)
    story = Story.where(id: sid).first
    volume = story.volume
    part = volume.part
    chapter = part.chapter
    {cid: chapter.id, pid: part.id, vid: volume.id, sid: sid}
  end
end

