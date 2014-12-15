Rails.application.routes.draw do
  root to: 'mains#list'

  ##--  Login
  get  'login'  => 'sessions#new'
  post 'login'  => 'sessions#login'
  get  'logout' => 'sessions#destroy'

  ##--  Main
  get 'mains'               => 'mains#list'
  get 'mains/chapters/:nid' => 'mains#chapters', as: :mains_chapters
  get 'mains/parts/:cid'    => 'mains#parts', as: :mains_parts
  get 'mains/volumes/:pid'  => 'mains#volumes', as: :mains_volumes
  get 'mains/stories/:vid'  => 'mains#stories', as: :mains_stories
  get 'mains/story/:sid'    => 'mains#show', as: :mains_show

  ##--  Admin
  # Novel
  get   'admin'             => 'novels#list', as: :novels_list
  get   'admin/add'         => 'novels#add', as: :novels_add
  post  'admin/add'         => 'novels#create'
  get   'admin/:nid/edit'   => 'novels#edit', as: :novels_edit
  patch 'admin/:nid/edit'   => 'novels#update'
  get   'admin/:nid/active' => 'novels#active', as: :novels_active

  # Chapter
  get   'admin/:nid'             => 'chapters#list', as: :chapters_list
  get   'admin/:nid/add'         => 'chapters#add', as: :chapters_add
  post  'admin/:nid/add'         => 'chapters#create'
  get   'admin/:nid/:cid/edit'   => 'chapters#edit', as: :chapters_edit
  patch 'admin/:nid/:cid/edit'   => 'chapters#update'
  get   'admin/:nid/:cid/active' => 'chapters#active', as: :chapters_active

  # Many Chapters
  get   'admin/:nid'           => 'many_chapters#list'
  get   'admin/:nid/add_many'  => 'many_chapters#add', as: :many_chapters_add
  post  'admin/:nid/add_many'  => 'many_chapters#create'
  get   'admin/:nid/edit_many' => 'many_chapters#edit', as: :many_chapters_edit
  patch 'admin/:nid/edit_many' => 'many_chapters#update'

  # Part
  get   'admin/:nid/:cid'             => 'parts#list', as: :parts_list
  get   'admin/:nid/:cid/add'         => 'parts#add', as: :parts_add
  post  'admin/:nid/:cid/add'         => 'parts#create'
  get   'admin/:nid/:cid/:pid/edit'   => 'parts#edit', as: :parts_edit
  patch 'admin/:nid/:cid/:pid/edit'   => 'parts#update'
  get   'admin/:nid/:cid/:pid/active' => 'parts#active', as: :parts_active

  # Many Parts
  get   'admin/:nid/:cid'           => 'many_parts#list'
  get   'admin/:nid/:cid/add_many'  => 'many_parts#add', as: :many_parts_add
  post  'admin/:nid/:cid/add_many'  => 'many_parts#create'
  get   'admin/:nid/:cid/edit_many' => 'many_parts#edit', as: :many_parts_edit
  patch 'admin/:nid/:cid/edit_many' => 'many_parts#update'

  # Volume
  get   'admin/:nid/:cid/:pid'             => 'volumes#list', as: :volumes_list
  get   'admin/:nid/:cid/:pid/add'         => 'volumes#add', as: :volumes_add
  post  'admin/:nid/:cid/:pid/add'         => 'volumes#create'
  get   'admin/:nid/:cid/:pid/:vid/edit'   => 'volumes#edit', as: :volumes_edit
  patch 'admin/:nid/:cid/:pid/:vid/edit'   => 'volumes#update'
  get   'admin/:nid/:cid/:pid/:vid/active' => 'volumes#active', as: :volumes_active

  # Many Volumes
  get   'admin/:nid/:cid/:pid'           => 'many_volumes#list'
  get   'admin/:nid/:cid/:pid/add_many'  => 'many_volumes#add', as: :many_volumes_add
  post  'admin/:nid/:cid/:pid/add_many'  => 'many_volumes#create'
  get   'admin/:nid/:cid/:pid/edit_many' => 'many_volumes#edit', as: :many_volumes_edit
  patch 'admin/:nid/:cid/:pid/edit_many' => 'many_volumes#update'

  # Story
  get  'admin/:nid/:cid/:pid/:vid'             => 'stories#list', as: :stories_list
  get  'admin/:nid/:cid/:pid/:vid/add'         => 'stories#add', as: :stories_add
  post 'admin/:nid/:cid/:pid/:vid/add'         => 'stories#create'
  get  'admin/:nid/:cid/:pid/:vid/:sid/edit'   => 'stories#edit', as: :stories_edit
  post 'admin/:nid/:cid/:pid/:vid/:sid/edit'   => 'stories#update'
  get  'admin/:nid/:cid/:pid/:vid/:sid/active' => 'stories#active', as: :stories_active

  # Many Stories
  get   'admin/:nid/:cid/:pid/:vid'           => 'many_stories#list'
  get   'admin/:nid/:cid/:pid/:vid/add_many'  => 'many_stories#add', as: :many_stories_add
  post  'admin/:nid/:cid/:pid/:vid/add_many'  => 'many_stories#create'
  get   'admin/:nid/:cid/:pid/:vid/edit_many' => 'many_stories#edit', as: :many_stories_edit
  patch 'admin/:nid/:cid/:pid/:vid/edit_many' => 'many_stories#update'

  # Images
  get   'images/:nid'             => 'images#list', as: :images_list
  get   'images/:nid/add'         => 'images#add', as: :images_add
  post  'images/:nid/add'         => 'images#create'
  get   'images/:nid/:iid/edit'   => 'images#edit', as: :images_edit
  patch 'images/:nid/:iid/edit'   => 'images#update'
  get   'images/:nid/:iid/active' => 'images#active', as: :images_active
end

