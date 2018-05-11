describe StoryCreateService do
  let(:instance) { described_class.new(text: 'hoge', title: 'タイトル', comment: 'コメント') }

  describe '#call' do
    subject { instance.call }

    context '正常に実行された場合' do
      it 'Storyが1つできること' do
        expect(subject.title).to eq 'タイトル'
        expect(subject.comment).to eq 'コメント'
        expect(subject.no).to eq 1
        expect(subject.is_scene).to eq false
        expect(File.exist?(subject.filepath)).to eq true
        expect(Story.count).to eq 1
      end
    end
  end
end
