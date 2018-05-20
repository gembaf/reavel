require 'rails_helper'

RSpec.describe Fantasy::ChapterManager do
  let(:instance) { described_class.new(zip_file) }
  let(:zip_file) { Rails.root.join('spec', 'fixtures', 'fantasy', 'chapter.zip') }

  describe '#chapter_list_file' do
    subject { instance.chapter_list_file }

    it '正常に取得できること' do
      expect(subject).to eq '第一部.txt'
    end
  end

  describe '#mht_files' do
    subject { instance.mht_files }

    it '正常に取得できること' do
      expect(subject.count).to eq 3
    end
  end

  describe '#unzip' do
    subject { instance.unzip }

    it '正常に展開されること' do
      subject
      expect(File.exist?(instance.dir_path)).to eq true
    end
  end
end
