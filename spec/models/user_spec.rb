require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_valid) { FactoryBot.create(:user, name: 'Tanaka', email: 'user@example.com',password_digest: 'password') }

  it "is valid with a name and email and password_digest and admin" do
    expect(user_valid).to be_valid
  end
  # it "is invalid without name" do
  #   expect(user_invalid)
  # end
end
