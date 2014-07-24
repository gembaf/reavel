require 'rails_helper'

RSpec.describe NovelsController, :type => :controller do
  describe "GET #list" do
    before do
      get :list
    end

    describe "Status" do
      it { expect(response).to be_success }
    end

    describe "Attribute" do
      it { expect(assigns[:novels]).to be_a_new(Novel) }
    end

    describe "Template" do
      it { expect(response).to render_template(:list) }
    end
  end

  describe "GET #add" do
    before do
      get :add
    end

    describe "Status" do
      it { expect(response).to be_success }
    end

    describe "Attribute" do
      it { expect(assigns[:novel]).to be_a_new(Novel) }
    end

    describe "Template" do
      it { expect(response).to render_template(:add) }
    end
  end

  describe "POST #create" do
    before do
      post :create
    end

    describe "Status" do
      it { expect(response).not_to be_success }
    end

    describe "Attribute" do
      it { expect(response).to filter_param(:title, :summary, :comment, :mode) }
    end

    describe "Template" do
      it { expect(response).to redirect_to(novels_list_path) }
    end
  end

end

