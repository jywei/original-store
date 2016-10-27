require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  # subject(:admin_user) { User.create(email: Faker::Internet.email,
  #                                    password: "12345678",
  #                                    password_confirmation: "12345678",
  #                                    is_admin: true) }

  # subject(:normal_user) { User.create(email: Faker::Internet.email,
  #                                    password: "12345678",
  #                                    password_confirmation: "12345678") }

  subject(:admin_user)  { create(:admin_user) }
  subject(:normal_user) { create(:user) }

  # subject(:product) { Product.create(title: "macbook",
  #                                    price: "60000",
  #                                    quantity: "5",
  #                                    body: "Apple")}
  subject(:product) { create(:product) }

  describe "GET index" do
    context "login admin_user" do
      before { sign_in :user, admin_user }
      before { get :index }

      it { expect(response).to be_success }
      it { expect(response.header['Content-Type']).to include "text/html" }
    end

    context "login normal_user" do
      before { sign_in :user, normal_user }
      before { get :index }

      it { expect(response).to redirect_to root_path }
    end

    context "login admin_user with json" do
      before { sign_in :user, admin_user }
      before { get :index, format: :json }

      it { expect(response).to be_success }
      it { expect(response.header['Content-Type']).to include "application/json" }
    end

    context "login normal_user with json" do
      before { sign_in :user, normal_user }
      before { get :index, format: :json }

      it { expect(response).to redirect_to root_path }
    end
  end

  describe "GET new" do
    context "login admin_user" do
      before { sign_in :user, admin_user }
      before { get :new }

      it { expect(response).to be_success }
      it { expect(response.header['Content-Type']).to include "text/html" }
    end

    context "login normal_user" do
      before { sign_in :user, normal_user }
      before { get :new }

      it { expect(response).to redirect_to root_path }
    end
  end

  describe "GET edit" do
    context "login admin_user" do
      before { sign_in :user, admin_user }
      before { get :edit, id: product.id }

      it { expect(response).to be_success }
      it { expect(response.header['Content-Type']).to include "text/html" }
    end

    context "login normal_user" do
      before { sign_in :user, normal_user }
      before { get :edit, id: product.id }

      it { expect(response).to redirect_to root_path }
    end
  end

  describe "POST create" do
    context "login admin_user" do
      before { sign_in :user, admin_user }
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
      before { sign_in :user, normal_user }
      before { post :create, product: { title: "macbook",
                                        price: "60000",
                                        quantity: "5",
                                        body: "Apple" }}

      it { expect(response).to redirect_to root_path }
    end
  end

  describe "PUT/PATCH update" do
    context "login admin_user" do
      before { sign_in :user, admin_user }
      before { patch :update, id: product.id, product: { title: "Macbook Pro" } }

      it { is_expected.to redirect_to admin_products_path }
      it { expect(response.header['Content-Type']).to include "text/html" }
      it { expect(Product.find(product.id).title).to eq "Macbook Pro" }
    end

    context "login normal_user" do
      before { sign_in :user, normal_user }
      before { patch :update, id: product.id, product: { title: "Macbook Pro" } }

      it { expect(response).to redirect_to root_path }
    end
  end
end
