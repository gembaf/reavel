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
#

require 'kconv'

describe Story, type: :model do
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
end

