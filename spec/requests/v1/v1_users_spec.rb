require 'rails_helper'

RSpec.describe "V1::Users", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  before{ login_as(user, :scope => :user) }

  describe "GET /v1_users" do
    it "works! (now write some real specs)" do
      get v1_users_index_path
      expect(response).to have_http_status(200)
    end
  end
end
