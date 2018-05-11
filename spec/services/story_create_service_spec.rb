describe StoryCreateService do
  let(:instance) { described_class.new(text: 'hoge', title: 'タイトル', comment: 'コメント') }

  describe '#call' do
    subject { instance.call }

    before do
      stub_const('Story::READ_PER_MINUTES', 2)
    end

    context '正常に実行された場合' do
      it 'Storyが1つできること' do
        expect(subject.title).to eq 'タイトル'
        expect(subject.comment).to eq 'コメント'
        expect(subject.no).to eq 1
        expect(subject.is_scene).to eq false
        expect(subject.time).to eq 2
        expect(File.exist?(subject.filepath)).to eq true
        expect(Story.count).to eq 1
      end
    end

    context '異常が起きた場合' do
      before do
        allow_any_instance_of(Story).to receive(:write).and_raise
      end

      it 'rollbackすること' do
        subject rescue nil
        expect(Story.count).to eq 0
      end
    end
  end
end
