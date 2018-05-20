require 'rails_helper'

RSpec.describe FantasyStoryCreateService do
  let(:instance) { described_class.new(chapter: chapter, title: 'ほげ', mht_path: mht_path) }
  let(:mht_path) { Rails.root.join('spec', 'fixtures', 'fantasy', 'story.mht') }

  describe '#call' do
    subject { instance.call }

    let(:chapter) { create(:chapter, :top) }
    let(:expected_text) { File.read(Rails.root.join('spec', 'fixtures', 'fantasy', 'story.txt')) }

    it '正常にStoryが作成されること' do
      expect(subject.title).to eq 'ほげ'
      # FIXME mht_path の mht ファイルを真面目なものにする
      # expect(subject.read).to eq expected_text
    end
  end
end
