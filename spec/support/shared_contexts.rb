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
