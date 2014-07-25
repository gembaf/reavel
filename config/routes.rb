Rails.application.routes.draw do
  # Novel
  get  'novels/add'      => 'novels#add'
  post 'novels/add'      => 'novels#create'
  get  'novels/edit/:id' => 'novels#edit'
  post 'novels/edit/:id' => 'novels#update'
  get  'novels/list'     => 'novels#list'

  # Chapter
  get  'chapters/add'        => 'chapters#add'
  post 'chapters/add'        => 'chapters#create'
  get  'chapters/edit/:id'   => 'chapters#edit'
  post 'chapters/edit/:id'   => 'chapters#update'
  get  'chapters/list(/:id)' => 'chapters#list'

  # Part
  get  'parts/add'        => 'parts#add'
  post 'parts/add'        => 'parts#create'
  get  'parts/edit/:id'   => 'parts#edit'
  post 'parts/edit/:id'   => 'parts#update'
  get  'parts/list(/:id)' => 'parts#list'

  # Story
  get  'stories/add'        => 'stories#add'
  post 'stories/add'        => 'stories#create'
  get  'stories/edit/:id'   => 'stories#edit'
  post 'stories/edit/:id'   => 'stories#update'
  get  'stories/list(/:id)' => 'stories#list'
end

