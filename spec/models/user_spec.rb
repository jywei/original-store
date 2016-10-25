require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(email: email,
                               password: password,
                               password_confirmation: password_confirmation) }

  let(:email) { "user@test.com" }
  let(:password) { "12345678" }
  let(:password_confirmation) { "12345678" }

  it "is the first test" do
    is_expected.to be_present
  end

  it "test the creation of a user" do
    is_expected.to be_valid
  end

  # it "test user creation failure" do
  #   user = User.create(email: "",
  #                      password: "12345678",
  #                      password_confirmation: "12345678")
  #   expect(user).to be_invalid
  # end

  context "test user creation failure" do
    let(:email) { "" }

    it { is_expected.to be_invalid }
    it { expect(user.errors).to include(:email) } # test if the error from User
  end

  context "password should be equal to password confirmation" do
    let(:password_confirmation) { "not12345678" }

    # it { binding.pry }
    it { is_expected.to be_invalid }
    it { expect(user.errors).to include(:password_confirmation) }
  end

  describe "#admin?"
  describe "#to_admin"
  describe "#to_normal"
end
