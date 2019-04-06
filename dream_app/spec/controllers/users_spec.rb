require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "with valid params successfully routes to user page" do
      post :create, params: {user: {username: 'jimmy12', password: 'jimmy12'}}
      expect(response).to redirect_to(user_url(User.find_by(username: 'jimmy12')))
    end

    it "with invalid params routes back to sign up page" do
      post :create, params: {user: {username: 'jimmy12'}}
      expect(response).to redirect_to(new_user_url)
    end
  end

  describe "GET #show" do
    it "has status 200" do
      get :show
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

end