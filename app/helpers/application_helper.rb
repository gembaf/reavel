module ApplicationHelper
  def markdown(text)
    text.gsub!(/\r\n\r\n|\n\n/, "\n<br />")
    unless @markdown
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(renderer)
    end
    @markdown.render(text).html_safe
  end

  def side_menu(object)
    render partial: 'side_menu', locals: { brothers: object.brothers, current_id: object.id }
  end
end
