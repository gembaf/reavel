require 'rails_helper'

RSpec.describe Fantasy::Command::ScrapeMht do
  let(:instance) { described_class.new }

  describe '#execute' do
    subject { instance.execute(path) }

    let(:path) { Rails.root.join('spec', 'fixtures', 'fantasy', 'story.mht') }
    let(:result) do
      <<-TEXT.strip_heredoc
         PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
         L0VOIj4NCjxIVE1MPjxIRUFEPjxUSVRMRT6T8Y6fjLOXoIGXgtOCvYLOPC9USVRMRT4NCjxNRVRB
         IGh0dHAtZXF1aXY9Q29udGVudC10eXBlIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD1TaGlm
      TEXT
    end

    it '対象のテキストを正しく抽出できること' do
      expect(subject).to eq result.gsub(/\r\n|\n/, '')
    end
  end
end

