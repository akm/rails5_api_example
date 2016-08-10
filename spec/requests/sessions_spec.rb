require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /sessions" do
    it "login timeout and meta/logged-in key test" do
      user = FactoryGirl.create(:user, updated_at: 1.hour.ago)
      # Not logged in, because of timeout
      get '/users', params: nil, headers: { 'X-Api-Key' => user.token }
      expect(response).to have_http_status(:success)
      jdata = JSON.parse response.body
      p jdata
      expect(jdata['meta']['logged-in']).to be_falsy
      # Log in
      post '/sessions',
           params: {
             data: {
               type: 'sessions',
               attributes: {
                 name: user.name,
                 password: 'password'
               }
             }
           }.to_json,
           headers: { 'Content-Type' => 'application/vnd.api+json' }
      expect(response).to have_http_status(:created)
      jdata = JSON.parse response.body
      token = jdata['data']['attributes']['token']
      expect(token).not_to eq user.token
      # Logged in
      get '/users', params: nil,
          headers: { 'X-Api-Key' => token }
      expect(response).to have_http_status(:success)
      jdata = JSON.parse response.body
      expect(jdata['meta']['logged-in']).to be_truthy
    end
  end
end
