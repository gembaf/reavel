Rails.application.routes.draw do
  # Novel
  get   'novels/add'        => 'novels#add'
  post  'novels/add'        => 'novels#create'
  get   'novels/edit/:id'   => 'novels#edit', as: :novels_edit
  patch 'novels/edit/:id'   => 'novels#update'
  get   'novels/list'       => 'novels#list'
  get   'novels/active/:id' => 'novels#active'

  # Chapter
  get  'chapters/add'        => 'chapters#add'
  post 'chapters/add'        => 'chapters#create'
  get  'chapters/edit/:id'   => 'chapters#edit', as: :chapters_edit
  post 'chapters/edit/:id'   => 'chapters#update'
  get  'chapters/list(/:id)' => 'chapters#list', as: :chapters_list

  # Part
  get  'parts/add'        => 'parts#add'
  post 'parts/add'        => 'parts#create'
  get  'parts/edit/:id'   => 'parts#edit', as: :parts_edit
  post 'parts/edit/:id'   => 'parts#update'
  get  'parts/list(/:id)' => 'parts#list', as: :parts_list

  # Story
  get  'stories/add'        => 'stories#add'
  post 'stories/add'        => 'stories#create'
  get  'stories/edit/:id'   => 'stories#edit', as: :stories_edit
  post 'stories/edit/:id'   => 'stories#update'
  get  'stories/list(/:id)' => 'stories#list', as: :stories_list
end

