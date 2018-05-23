zip_file_path = ARGV.first

raise 'NotFound' unless File.exist?(zip_file_path)

ActiveRecord::Base.transaction do
  novel = Novel.create(title: 'ファンタジー俺')

  Chapter.create(title: '第一部', no: 1, novel: novel)
  Chapter.create(title: '第二部', no: 2, novel: novel)
  Chapter.create(title: '第三部', no: 3, novel: novel)
  Chapter.create(title: '第四部', no: 4, novel: novel)

  FantasyChapterCreateService.new(novel.children[0], "#{zip_file_path}/1_01.zip").call

  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_01.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_02.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_03.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_04.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_05.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_06.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_07.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_08.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_09.zip").call
  FantasyChapterCreateService.new(novel.children[1], "#{zip_file_path}/2_10.zip").call

  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_01.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_02.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_03.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_04.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_05.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_06.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_07.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_08.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_09.zip").call
  FantasyChapterCreateService.new(novel.children[2], "#{zip_file_path}/3_10.zip").call

  FantasyChapterCreateService.new(novel.children[3], "#{zip_file_path}/4_01.zip").call
  FantasyChapterCreateService.new(novel.children[3], "#{zip_file_path}/4_02.zip").call
  FantasyChapterCreateService.new(novel.children[3], "#{zip_file_path}/4_03.zip").call
  FantasyChapterCreateService.new(novel.children[3], "#{zip_file_path}/4_04.zip").call
  FantasyChapterCreateService.new(novel.children[3], "#{zip_file_path}/4_05.zip").call
  FantasyChapterCreateService.new(novel.children[3], "#{zip_file_path}/4_06.zip").call
  FantasyChapterCreateService.new(novel.children[3], "#{zip_file_path}/4_07.zip").call
  FantasyChapterCreateService.new(novel.children[3], "#{zip_file_path}/4_08.zip").call
end

