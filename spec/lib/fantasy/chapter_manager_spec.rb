require 'rails_helper'

RSpec.describe Fantasy::ChapterManager do
  let(:instance) { described_class.new(zip_file) }
  let(:zip_file) { Rails.root.join('spec', 'fixtures', 'fantasy', 'chapter.zip') }

  describe '#unzip' do
    subject { instance.unzip }

    it '正常に展開されること' do
      subject
      expect(File.exist?(instance.dir_path)).to eq true
    end
  end
end
