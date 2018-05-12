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
#  level      :integer          default(1), not null
#  parent_id  :integer
#

require 'rails_helper'

RSpec.describe Chapter, type: :model do
  describe 'relations' do
    it { should belong_to(:novel) }
    it { should have_many(:stories).dependent(:destroy) }
  end

  describe '#parent' do
    subject { chapter.parent }

    let(:chapter) { create(:chapter, level: level, parent_id: parent_id) }

    context '親がいる場合' do
      let(:level) { 2 }
      let(:parent_id) { parent.id }
      let(:parent) { create(:chapter, :top) }

      it '親が返ること' do
        expect(subject).to eq parent
      end
    end

    context '親がいない場合' do
      let(:level) { 1 }
      let(:parent_id) { nil }

      it 'nilが返ること' do
        expect(subject).to eq nil
      end
    end
  end

  describe '#children' do
    subject { chapter.children }

    let(:chapter) { create(:chapter, :top) }

    context '子がいる場合' do
      let!(:children) do
        [
          create(:chapter, level: 2, parent_id: chapter.id, no: 1),
          create(:chapter, level: 2, parent_id: chapter.id, no: 2),
        ]
      end

      it 'no順に子が返ること' do
        expect(subject).to eq children
      end
    end

    context '子がいない場合' do
      it 'nilが返ること' do
        expect(subject).to eq nil
      end
    end
  end

  describe '#top?' do
    subject { chapter.top? }

    let(:chapter) { create(:chapter, level: level) }

    context 'levelが1の場合' do
      let(:level) { 1 }
      it { expect(subject).to eq true }
    end

    context 'levelが1以外の場合' do
      let(:level) { 2 }
      it { expect(subject).to eq false }
    end
  end
end
