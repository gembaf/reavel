Rails.application.routes.draw do
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

  # Part
  get   'admin/:nid/:cid'             => 'parts#list', as: :parts_list
  get   'admin/:nid/:cid/add'         => 'parts#add', as: :parts_add
  post  'admin/:nid/:cid/add'         => 'parts#create'
  get   'admin/:nid/:cid/:pid/edit'   => 'parts#edit', as: :parts_edit
  patch 'admin/:nid/:cid/:pid/edit'   => 'parts#update'
  get   'admin/:nid/:cid/:pid/active' => 'parts#active', as: :parts_active

  # Story
  get   'admin/:nid/:cid/:pid'             => 'stories#list', as: :stories_list
  get   'admin/:nid/:cid/:pid/add'         => 'stories#add', as: :stories_add
  post  'admin/:nid/:cid/:pid/add'         => 'stories#create'
  get   'admin/:nid/:cid/:pid/:sid/edit'   => 'stories#edit', as: :stories_edit
  patch 'admin/:nid/:cid/:pid/:sid/edit'   => 'stories#update'
  get   'admin/:nid/:cid/:pid/:sid/active' => 'stories#active', as: :stories_active
end

