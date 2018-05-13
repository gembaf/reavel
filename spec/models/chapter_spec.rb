# == Schema Information
#
# Table name: chapters
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  comment    :string(255)
#  no         :integer          not null
#  novel_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe Chapter, type: :model do
  describe 'relations' do
    it { should belong_to(:novel) }
    it { should have_many(:stories).dependent(:destroy) }
  end

  describe '#parent' do
    subject { chapter.parent }

    let(:chapter) { create(:chapter, parent_id: parent_id) }

    context '親がいる場合' do
      let(:parent_id) { parent.id }
      let(:parent) { create(:chapter, :top) }

      it '親が返ること' do
        expect(subject).to eq parent
      end
    end

    context '親がいない場合' do
      let(:parent_id) { 0 }

      it 'nilが返ること' do
        expect(subject).to eq nil
      end
    end
  end

  describe '#children' do
    subject { chapter.children }

    let(:chapter) { create(:chapter, :top) }

    context 'chapterとstoryの子がいる場合' do
      let!(:children) do
        [
          create(:chapter, parent_id: chapter.id, no: 1),
          create(:chapter, parent_id: chapter.id, no: 2),
        ]
      end

      it 'no順に子が返ること' do
        expect(subject).to eq children
      end
    end

    context '子がいない場合' do
      it '[]が返ること' do
        expect(subject).to eq []
      end
    end
  end

  describe '#brothers' do
    include_context 'novel!'

    subject { chapter.brothers }

    context 'トップレベルのChapterだった場合' do
      let(:chapter) { chapters.select(&:top?).sample }
      it '兄弟関係にあるChapterが返ること' do
        expect(subject.count).to eq 3
      end
    end

    context '子供のChapterだった場合' do
      let(:chapter) { chapters.reject(&:top?).sample }
      it '兄弟関係にあるChapterが返ること' do
        expect(subject.count).to eq 3
      end
    end

    context '他のNovelのChapterだった場合' do
      let(:chapter) { create(:chapter, :top, novel: another_novel) }
      let(:another_novel) { create(:novel) }

      it '自分のNovelの兄弟関係にあるChapterのみが返ること' do
        expect(subject.count).to eq 1
      end
    end
  end

  describe '#top?' do
    subject { chapter.top? }

    let(:chapter) { create(:chapter, parent_id: parent_id) }

    context 'parent_idが0の場合' do
      let(:parent_id) { 0 }
      it { expect(subject).to eq true }
    end

    context 'parent_idが1以外の場合' do
      let(:parent_id) { 3 }
      it { expect(subject).to eq false }
    end
  end
end
