require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  subject(:user) { create(:admin_user) }
  subject(:admin_user) { create(:admin_user) }
  subject(:normal_user){ create(:user) }
  subject(:product)    { create(:product) }

  shared_examples_for "valid: access" do
    it { expect(response).to be_success }
    it { expect(response.header['Content-Type']).to include "text/html" }
  end

  before { sign_in :user, user }

  describe "GET index" do
    context "format html" do
      before { get :index }
      it_behaves_like "valid: access"

      context "normal user" do
        let(:user) { create(:user) }
        it { expect(response).to redirect_to root_path }
      end
    end

    context "format json" do
      before { get :index, format: :json }

      it { expect(response).to be_success }
      it { expect(response.header['Content-Type']).to include "application/json" }

      context "normal user" do
        let(:user) { create(:user) }
        it { expect(response).to redirect_to root_path }
      end
    end
  end

  describe "GET new" do
    before { get :new }
    it_behaves_like "valid: access"

    context "login normal_user" do
      let(:user) { create(:user) }
      it { expect(response).to redirect_to root_path }
    end
  end

  describe "GET edit" do
    context "login admin_user" do
      before { get :edit, id: product.id }
      it_behaves_like "valid: access"
    end

    context "login normal_user" do
      let(:user) { create(:user) }
      before { get :edit, id: product.id }
      it { expect(response).to redirect_to root_path }
    end
  end

  describe "POST create" do
    context "login admin_user" do
      before { post :create, product: { title: "macbook",
                                        price: "60000",
                                        quantity: "5",
                                        body: "Apple" }}

      it { expect(Product.count).to eq 1 }
      it { is_expected.to redirect_to admin_products_path }

      it "create product fail" do
        post :create, product: { price: "60000",
                                 quantity: "5",
                                 body: "Apple" }
        is_expected.to render_template :new
      end
    end

    context "login normal_user" do
      let(:user) { create(:user) }
      before { post :create, product: { title: "macbook",
                                        price: "60000",
                                        quantity: "5",
                                        body: "Apple" }}
      it { expect(response).to redirect_to root_path }
    end
  end

  describe "PUT/PATCH update" do
    context "login admin_user" do
      before { patch :update, id: product.id, product: { title: "Macbook Pro" } }
      it { is_expected.to redirect_to admin_products_path }
      it { expect(response.header['Content-Type']).to include "text/html" }
      it { expect(Product.find(product.id).title).to eq "Macbook Pro" }
    end

    context "login normal_user" do
      let(:user) { create(:user) }
      before { patch :update, id: product.id, product: { title: "Macbook Pro" } }
      it { expect(response).to redirect_to root_path }
    end
  end
end
