require 'rails_helper'

RSpec.describe Fantasy::Command::CreateChapterList do
  let(:instance) { described_class.new }

  describe '#execute' do
    it { expect(instance.execute).to eq 'hoge' }
  end

  describe '#story_title' do
    subject { instance.story_title(line) }

    context 'シンプルな文字列が来た場合' do
      let(:line) { '第1話　発端(1/5)' }
      it 'タイトルを抜き出せること'do
        expect(subject).to eq '発端'
      end
    end

    context '複雑な文字列が来た場合' do
      let(:line) { '・ファンタジー俺　第四部　閑話31　とあるパーティの一日(1/5)' }
      it 'タイトルを抜き出せること'do
        expect(subject).to eq 'とあるパーティの一日'
      end
    end
  end

  describe '#small_chapter_title' do
    subject { instance.small_chapter_title(line) }

    context 'シンプルな文字列が来た場合' do
      let(:line) { '・首なし騎士隊長編' }
      it 'タイトルを抜き出せること'do
        expect(subject).to eq '首なし騎士隊長'
      end
    end

    context '複雑な文字列が来た場合' do
      let(:line) { '・完全敗北、そして……編' }
      it 'タイトルを抜き出せること'do
        expect(subject).to eq '完全敗北、そして……'
      end
    end
  end

  describe '#big_chapter_title' do
    subject { instance.big_chapter_title(line) }

    context 'シンプルな文字列が来た場合' do
      let(:line) { '●第一章：無垢なる少女' }
      it 'タイトルを抜き出せること'do
        expect(subject).to eq '無垢なる少女'
      end
    end

    context '複雑な文字列が来た場合' do
      let(:line) { '●第四部　第六章：魔王が来たりて笛を吹く' }
      it 'タイトルを抜き出せること'do
        expect(subject).to eq '魔王が来たりて笛を吹く'
      end
    end
  end
end

