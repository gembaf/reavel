module ApplicationHelper
  def format_time(time)
    "約 #{time} 分"
  end

  def format_episode(episode)
    "全 #{episode} 話"
  end

  def get_titles(ids)
    names = %w(novels chapters parts volumes stories)
    models = [Novel, Chapter, Part, Volume, Story]
    titles = {}

    elem = ids.zip(names).zip(models).map {|e| e.flatten}
    elem.each do |id, name, model|
      next if id.nil?
      titles[name] = model.where(id: id).first.title
    end
    titles
  end
end

