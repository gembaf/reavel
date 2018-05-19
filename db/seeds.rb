# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_bot'

##-- 普通
normal = FactoryBot.create(:novel, title: '普通の小説', summary: '普通っぽい')

parents = [
  FactoryBot.create(:chapter, :top, novel: normal),
  FactoryBot.create(:chapter, :top, novel: normal),
  FactoryBot.create(:chapter, :top, novel: normal),
]
children = parents.map do |parent|
  [
    FactoryBot.create(:chapter, parent_id: parent.id, novel: normal, title: '子チャプター1'),
    FactoryBot.create(:chapter, parent_id: parent.id, novel: normal, title: '子チャプター2'),
  ]
end

children.flatten.each.with_index(1) do |chapter, i|
  StoryCreateService.new(chapter: chapter, text: "てき\nすと", title: "タイトル#{i}-1", comment: 'あ').call
  StoryCreateService.new(chapter: chapter, text: "てき\nすと", title: "タイトル#{i}-2").call
end

##-- 文字が長め
long = FactoryBot.create(:novel, title: 'たいとるううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううう', summary: 'がいよううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううううう')

parents = [
  FactoryBot.create(:chapter, :top, novel: long, title: '親チャプターーーーーーーーーーーーーーーーーーー1'),
  FactoryBot.create(:chapter, :top, novel: long, title: '親チャプターーーーーーーーーーーーーーーーーーー2'),
  FactoryBot.create(:chapter, :top, novel: long, title: '親チャプター333333333333333333333333333333333333333333333333333333333333333333333'),
]
children = parents.map do |parent|
  [
    FactoryBot.create(:chapter, parent_id: parent.id, novel: long, title: '子子子子子子子子子子子子子子子子子子子子子子子子子子子子子子チャプター1'),
    FactoryBot.create(:chapter, parent_id: parent.id, novel: long, title: '子子子子子子子子子子子子子子子子子子子子子子子子子子子子子子チャプター2'),
  ]
end

children.flatten.each.with_index(1) do |chapter, i|
  StoryCreateService.new(chapter: chapter, text: "てき\nすと", title: "タイトルううううううううううううううううううううううううううううううううううううう#{i}-1", comment: 'あ').call
  StoryCreateService.new(chapter: chapter, text: "てき\nすと", title: "タイトル#{i}-2").call
end

##-- 構成が複雑
complex = FactoryBot.create(:novel, title: '小説', summary: 'これは小説です')

