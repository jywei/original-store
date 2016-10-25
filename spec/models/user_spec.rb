require 'rails_helper'

RSpec.describe User, type: :model do
  it "is the first test" do
    expect(User).to be_present
  end

  it "test the creation of a user" do
    user = User.create(email: "user@test.com",
                       password: "12345678",
                       password_confirmation: "12345678")
    expect(user).to be_valid
  end
end
