Rails.application.routes.draw do
  # Novel
  get  'novels/add'      => 'novels#add'
  post 'novels/add'      => 'novels#create'
  get  'novels/edit/:id' => 'novels#edit'
  post 'novels/edit/:id' => 'novels#update'
  get  'novels/list'     => 'novels#list'
end

