require 'rails_helper'

RSpec.describe Reavel::Iconv do
  describe '.read_and_split' do
    subject { described_class.read_and_split(path) }
    let(:path) { Rails.root.join('spec', 'fixtures', 'fantasy', 'chapter_list.txt') }

    it '正しくエンコードされて分割されること' do
      expect(subject.first).to eq '●第一章：無垢なる少女'
    end
  end
end

