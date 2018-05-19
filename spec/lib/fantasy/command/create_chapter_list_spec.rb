require 'rails_helper'

RSpec.describe Fantasy::Command::CreateChapterList do
  let(:instance) { described_class.new }

  describe '#execute' do
    it { expect(instance.execute).to eq 'hoge' }
  end
end

