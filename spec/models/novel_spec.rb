# == Schema Information
#
# Table name: novels
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  summary    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Novel, type: :model do
  describe 'relations' do
    it { should have_many(:chapters).dependent(:destroy) }
  end

  describe '#children' do
    include_context 'novel!'

    subject { novel.children }

    it 'トップレベルのチャプターのみ取れること' do
      expect(novel.chapters.count).not_to eq 3
      expect(subject.count).to eq 3
    end
  end

  describe '#destroy' do
    include_context 'novel'

    subject { novel.destroy }

    before do
      novel
      chapters
      stories
      allow_any_instance_of(Story).to receive(:delete_text)
    end

    context 'novelを削除した場合' do
      it 'chapter と story も削除されること' do
        expect(Novel.count).to eq 1
        expect(Chapter.count).to eq 3
        expect(Story.count).to eq 9
        subject
        expect(Novel.count).to eq 0
        expect(Chapter.count).to eq 0
        expect(Story.count).to eq 0
      end
    end
  end
end
