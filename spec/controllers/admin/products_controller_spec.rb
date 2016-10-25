require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  subject(:admin_user) { User.create(email: "admin@example.com",
                                 password: "12345678",
                                 password_confirmation: "12345678",
                                 is_admin: true) }
  subject(:normal_user) { User.create(email: "user@example.com",
                                  password: "12345678",
                                  password_confirmation: "12345678",
                                  is_admin: false) }

  describe "GET index" do
    before { sign_in :user, admin_user }
    before { get :index }

    it { expect(response).to be_success }
    it { expect(response.header['Content-Type']).to include "text/html" }

    context "json" do
      before { get :index, format: :json }
      it { expect(response.header['Content-Type']).to include "application/json" }
    end
  end

  describe "GET new" do

  end

  describe "POST create" do

  end

  describe "GET edit" do

  end

  describe "PATCH update" do

  end

end
