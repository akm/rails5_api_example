require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do
    it "Creating new session with valid data should create new session" do
      user = FactoryGirl.create(:user)
      @request.headers["Content-Type"] = 'application/vnd.api+json'
      post :create, params: {
             data: {
               type: 'sessions',
               attributes: {
                 name: user.name,
                 password: 'password'
               }
             }
           }
      expect(response).to have_http_status(:created)
      jdata = JSON.parse response.body
      refute_equal user.token, jdata['data']['attributes']['token']
    end
  end

  describe "GET #destroy" do
    it "Should delete session" do
      user = FactoryGirl.create(:user)
      delete :destroy, params: { id: user.token }
      expect(response).to have_http_status(:no_content)
    end
  end

end
