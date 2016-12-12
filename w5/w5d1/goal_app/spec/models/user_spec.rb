require 'rails_helper'

begin
  User
rescue
  User = nil
end

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "find by credentials" do
    it "finds user by username and password" do
      User.create!(username: "useruser", password: "password")
      expect(User.find_by_credentials("useruser", "password")).not_to be_nil
    end
    it "returns nil for unfound user" do
      User.create!(username: "useruser", password: "password")
      expect(User.find_by_credentials("notfounduser", "password")).to be_nil
    end
  end

  describe "password encryption" do
    it "does not save password to database" do
      User.create!(username: "user1", password: "password")
      user = User.find_by_username("user1")
      expect(user.password).not_to be("password")
    end

    it "encrypts the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "user1", password: "password")
    end
  end

  describe "session token" do
    it "assigns a session_token if not given" do
      jack = User.create(username: "user2", password: "password")
      expect(jack.session_token).not_to be_nil
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }


end
