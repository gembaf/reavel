Rails.application.routes.draw do
  ##-- Viewer
  get 'viewer' => 'viewer#novels'
  get 'viewer/:novel_id' => 'viewer#chapters', as: :viewer_top_chapters
  get 'viewer/:novel_id/:chapter_id' => 'viewer#chapters', as: :viewer_chapters
  get 'viewer/:novel_id/:chapter_id/:story_id' => 'viewer#show', as: :viewer_show
end
