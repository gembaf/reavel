require 'base64'

class FantasyStoryCreateService
  def initialize(chapter:, title:, mht_path:)
    @chapter = chapter
    @title = title
    @mht_path = mht_path
  end

  def call
    Rails.logger.info("[FantasyStoryCreateService] title: #{@title}, mht_path: #{@mht_path}")

    scraped_text = text
    StoryCreateService.new(chapter: @chapter, text: scraped_text, title: @title).call
  end

  private

  def text
    html_path = mht2html
    Fantasy::Command::ScrapeHtml.execute(html_path)
  end

  def mht2html
    encoded_text = Fantasy::Command::ScrapeMht.execute(@mht_path)
    data = Base64.decode64(encoded_text)
    Rails.root.join('tmp', "#{SecureRandom.uuid}.html").tap do |tmp_path|
      File.write(tmp_path, Reavel::Iconv.encode(data))
    end
  end
end
