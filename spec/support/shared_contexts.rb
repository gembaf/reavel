shared_context 'novel' do
  let(:novel) { create(:novel) }
  let(:chapters) { create_list(:chapter, 3, novel: novel) }
  let(:stories) do
    chapters.each do |chapter|
      create_list(:story, 3, chapter: chapter)
    end
  end
end
