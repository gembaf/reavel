shared_context 'novel' do
  let(:novel) { create(:novel) }
  let(:chapters) { create_list(:chapter, 3, novel: novel) }
  let(:stories) do
    chapters.each do |chapter|
      create_list(:story, 3, chapter: chapter)
    end
  end
end

shared_context 'novel!' do
  let!(:novel) { create(:novel) }
  let!(:chapters) do
    parents = create_list(:chapter, 3, :top, novel: novel)
    children = parents.map do |parent|
      create_list(:chapter, 3, novel: novel, parent_id: parent.id)
    end
    [parents, children].flatten
  end
  let!(:stories) do
    chapters.each do |chapter|
      create_list(:story, 3, chapter: chapter)
    end
  end
end

shared_context 'complex_novel!' do
  let!(:novel) { create(:novel) }

  let!(:chapter1) { create(:chapter, novel: novel, no: 1, parent_id: 0) }
  let!(:chapter2) { create(:chapter, novel: novel, no: 2, parent_id: 0) }
  let!(:chapter3) { create(:chapter, novel: novel, no: 3, parent_id: 0) }

  let!(:chapter1_1) { create(:chapter, novel: novel, parent_id: chapter1.id, no: 1) }
  let!(:chapter1_2) { create(:chapter, novel: novel, parent_id: chapter1.id, no: 2) }
  let!(:chapter1_3) { create(:chapter, novel: novel, parent_id: chapter1.id, no: 3) }

  let!(:chapter2_1) { create(:chapter, novel: novel, parent_id: chapter2.id, no: 1) }
  let!(:chapter2_2) { create(:chapter, novel: novel, parent_id: chapter2.id, no: 2) }
  let!(:chapter2_3) { create(:chapter, novel: novel, parent_id: chapter2.id, no: 3) }

  let!(:story1_1_1) { create(:story, chapter: chapter1_1, no: 1) }
  let!(:story1_1_2) { create(:story, chapter: chapter1_1, no: 2) }
  let!(:story1_1_3) { create(:story, chapter: chapter1_1, no: 3) }

  let!(:story1_2_1) { create(:story, chapter: chapter1_2, no: 1) }

  let!(:story1_3_1) { create(:story, chapter: chapter1_3, no: 1) }

  let!(:story2_1_1) { create(:story, chapter: chapter2_1, no: 1) }
  let!(:story2_1_2) { create(:story, chapter: chapter2_1, no: 2) }
  let!(:story2_1_3) { create(:story, chapter: chapter2_1, no: 3) }
end

