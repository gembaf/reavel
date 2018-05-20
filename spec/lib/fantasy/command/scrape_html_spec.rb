require 'rails_helper'

RSpec.describe Fantasy::Command::ScrapeHtml do
  let(:instance) { described_class.new }

  describe '#execute' do
    subject { instance.execute(path) }

    let(:path) { Rails.root.join('spec', 'fixtures', 'fantasy', 'story.html') }
    let(:result) { File.read(Rails.root.join('spec', 'fixtures', 'fantasy', 'story.txt')) }

    it '対象のテキストを正しく抽出できること' do
      expect(subject).to eq result
    end
  end
end

