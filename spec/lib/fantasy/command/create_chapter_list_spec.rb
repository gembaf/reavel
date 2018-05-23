require 'rails_helper'

RSpec.describe Fantasy::Command::CreateChapterList do
  let(:instance) { described_class.new }

  describe '#execute' do
    subject { instance.execute(path) }
    let(:path) { Rails.root.join('spec', 'fixtures', 'fantasy', 'chapter_list.txt') }

    it '正しく分割されていること' do
      expect(subject.count).to eq 2

      chapter1 = subject[0]
      expect(chapter1.children.count).to eq 2

      chapter1_1 = chapter1.children[0]
      expect(chapter1_1.children.count).to eq 2

      chapter1_2 = chapter1.children[1]
      expect(chapter1_2.children.count).to eq 2

      chapter2 = subject[1]
      expect(chapter2.children.count).to eq 2

      chapter2_1 = chapter2.children[0]
      expect(chapter2_1.children.count).to eq 1

      chapter2_2 = chapter2.children[1]
      expect(chapter2_2.children.count).to eq 3
    end
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

  describe '#title_type' do
    subject { instance.title_type(line) }

    context 'チャプター大の場合' do
      let(:line) { '●第三部　第九章：吸血城主' }
      it { expect(subject).to eq described_class::TYPE_BIG_CHAPTER }
    end

    context 'チャプター小の場合' do
      let(:line) { '・新たな家族編' }
      it { expect(subject).to eq described_class::TYPE_SMALL_CHAPTER }
    end

    context 'ストーリーの場合' do
      let(:line) { '第32話　野伏（のぶせり）(1/5)' }
      it { expect(subject).to eq described_class::TYPE_STORY }
    end

    context '複雑な文字列が来た場合' do
      let(:line) { '・ファンタジー俺　番外編　聖騎士見習いシモンの道程(1/5)' }
      it { expect(subject).to eq described_class::TYPE_STORY }
    end

    context 'よくわからないものだった場合' do
      let(:line) { "\n" }
      it { expect { subject }.to raise_error(RuntimeError) }
    end
  end
end

