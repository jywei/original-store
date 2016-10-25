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
  context "測試 user 建立失敗" do
    let(:email) { "" }

    it { is_expected.to be_invalid }
    it { expect(user.errors).to include(:email) } # 驗證是否為 email 的錯誤
  end
end
