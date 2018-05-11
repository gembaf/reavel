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

describe Story do
  describe '#write and #read' do
    subject { story.write(text) }

    let(:story) { create(:story, uuid: 'hoge') }

    context '普通のテキストを渡した場合' do
      let(:text) { 'てすとtest' }

      it '正しく書き込まれて読み取れること' do
        subject
        expect(story.read).to eq text
      end
    end
  end
end

