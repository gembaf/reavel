Rails.application.routes.draw do
  ##-- Viewer
  get 'viewer' => 'viewer#novels'
  get 'viewer/:novel_id' => 'viewer#chapters', as: :viewer_chapters
  get 'viewer/:novel_id/:story_id' => 'viewer#stories', as: :viewer_stories
end
