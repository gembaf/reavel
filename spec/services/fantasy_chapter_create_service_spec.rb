require 'rails_helper'

RSpec.describe FantasyChapterCreateService do
  let(:instance) { described_class.new(chapter, zip_file) }
  let(:zip_file) { Rails.root.join('spec', 'fixtures', 'fantasy', 'chapter.zip') }

  describe '#call' do
    subject { instance.call }

    let(:chapter) { create(:chapter, :top) }

    context '空のチャプターに対して実行した場合' do
      it '正常に追加されること' do
        subject

        expect(chapter.children.pluck(:title)).to eq ['無垢なる少女', '貴婦人討伐']
        expect(chapter.children.pluck(:no)).to eq [1, 2]

        chapter1 = chapter.children[0]
        expect(chapter1.children.pluck(:title)).to eq ['名もなき出会い']
        expect(chapter1.children.pluck(:no)).to eq [1]

        chapter1_1 = chapter1.children[0]
        expect(chapter1_1.stories.pluck(:title)).to eq ['発端']
        expect(chapter1_1.stories.pluck(:no)).to eq [1]

        chapter2 = chapter.children[1]
        expect(chapter2.children.pluck(:title)).to eq ['首なし騎士隊長', '嫁たちの戦い']
        expect(chapter2.children.pluck(:no)).to eq [1, 2]

        chapter2_1 = chapter2.children[0]
        expect(chapter2_1.stories.pluck(:title)).to eq ['俺']
        expect(chapter2_1.stories.pluck(:no)).to eq [1]

        chapter2_2 = chapter2.children[1]
        expect(chapter2_2.stories.pluck(:title)).to eq ['野営']
        expect(chapter2_2.stories.pluck(:no)).to eq [1]
      end
    end

    context '既に他のチャプターが存在するものに対して実行した場合' do
      before do
        create(:chapter, parent_id: chapter.id, no: 1, title: 'ほげ')
        create(:chapter, parent_id: chapter.id, no: 2, title: 'ふー')
      end

      it '正常に追加されること' do
        subject

        expect(chapter.children.pluck(:title)).to eq ['ほげ', 'ふー', '無垢なる少女', '貴婦人討伐']
        expect(chapter.children.pluck(:no)).to eq [1, 2, 3, 4]
      end
    end
  end
end
