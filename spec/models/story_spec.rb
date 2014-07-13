require 'rails_helper'

RSpec.describe Story, :type => :model do
  describe "Association" do
    it { expect(subject).to belong_to(:part) }
  end

  describe "Validation" do
    it { expect(subject).to validate_presence_of(:part_id) }
    it { expect(subject).to validate_presence_of(:title) }
    it { expect(subject).to ensure_length_of(:title).is_at_most(250) }
    it { expect(subject).to ensure_length_of(:comment).is_at_most(250) }
  end
end

