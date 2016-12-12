require 'rails_helper'

begin
  UsersController
rescue
  UsersController = nil
end

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create!({username: "user", password: "password"}) }

  describe "GET #show" do
    it "renders show template" do
      get :show, id: user.id
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates presence of username and pword" do
        post :create, user: { username: "user", password: "" }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
      it "validates length of pword at least 6" do
        post :create, user: { username: "user", password: "123" }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
    context "with valid params" do
      it "redirects user to show page on success" do
        post :create, user: { username: "user", password: "password" }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

end
