# == Schema Information
#
# Table name: stories
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  comment    :string(255)
#  no         :integer          not null
#  time       :integer          default(0), not null
#  uuid       :string(255)      not null
#  is_scene   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chapter_id :integer          not null
#

require 'kconv'
require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'relations' do
    it { should belong_to(:chapter) }
  end

  describe '#write and #read' do
    subject do
      story.write(text)
      story.read
    end

    let(:story) { create(:story, uuid: 'hoge') }
    let(:expected_text) do
      <<-TEXT.strip_heredoc
        てすとtest
        あいうえお
      TEXT
    end

    context '普通のテキストを渡した場合' do
      let(:text) { expected_text }

      it '正しく書き込まれて読み取れること' do
        expect(subject).to eq expected_text
      end
    end

    context 'Shift_JISのテキストを渡した場合' do
      let(:text) { expected_text.tosjis }

      it '正しく書き込まれて読み取れること' do
        expect(subject).to eq expected_text
      end
    end
  end

  describe '#brothers' do
    subject { story.brothers }

    let(:story) { stories.first }
    let(:stories) do
      [
        create(:story, chapter: current_chapter),
        create(:story, chapter: current_chapter),
        create(:story, chapter: another_chapter),
      ]
    end
    let(:current_chapter) { create(:chapter) }
    let(:another_chapter) { create(:chapter) }

    it '同じchapterに紐付くStoryを返すこと' do
      expect(subject).to eq stories[0..1]
    end
  end

  describe '#next' do
    include_context 'complex_novel!'

    subject { story.next }

    context '次のStoryが存在する場合' do
      let(:story) { story1_1_1 }
      let(:next_story) { story1_1_2 }

      it { expect(subject).to eq next_story }
    end

    context '親をたどれば次のStoryが存在する場合' do
      let(:story) { story1_1_3 }
      let(:next_story) { story1_2_1 }

      it { expect(subject).to eq next_story }
    end

    context '親の親をたどれば次のStoryが存在する場合' do
      let(:story) { story1_3_1 }
      let(:next_story) { story2_1_1 }

      it { expect(subject).to eq next_story }
    end

    context '親をたどっても次のStoryが存在しない場合' do
      let(:story) { story2_1_3 }
      let(:next_story) { nil }

      it { expect(subject).to eq next_story }
    end
  end

  describe '#prev' do
    include_context 'complex_novel!'

    subject { story.prev }

    context '前のStoryが存在する場合' do
      let(:story) { story1_1_2 }
      let(:prev_story) { story1_1_1 }

      it { expect(subject).to eq prev_story }
    end

    context '親をたどれば前のStoryが存在する場合' do
      let(:story) { story1_2_1 }
      let(:prev_story) { story1_1_3 }

      it { expect(subject).to eq prev_story }
    end

    context '親の親をたどれば前のStoryが存在する場合' do
      let(:story) { story2_1_1 }
      let(:prev_story) { story1_3_1 }

      it { expect(subject).to eq prev_story }
    end

    context '親をたどっても前のStoryが存在しない場合' do
      let(:story) { story1_1_1 }
      let(:prev_story) { nil }

      it { expect(subject).to eq prev_story }
    end
  end

  describe '.required_time' do
    subject { described_class.required_time(text) }
    let(:text) { 'a' * 2500 }

    it { expect(subject).to eq 2 }
  end
end

