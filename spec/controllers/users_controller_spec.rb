# coding: utf-8
require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe UsersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:user)
  }

  let(:invalid_attributes) {
    valid_attributes.merge(name: '')
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:users)).to eq([user])
      expect(response).to have_http_status(:success)
      expect(response.headers['Content-Type']).to match %r{application/vnd.api\+json}
      jdata = JSON.parse(response.body)
      expect(jdata['data'].length).to eq 1
      expect(jdata['data'][0]['type']).to eq 'users'
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, params: {id: user.to_param}, session: valid_session
      expect(assigns(:user)).to eq(user)
      expect(response).to have_http_status(:success)
      expect(response.headers['Content-Type']).to match %r{application/vnd.api\+json}
      jdata = JSON.parse(response.body)
      expect(jdata['data']['id']).to eq user.id.to_s
      expect(jdata['data']['attributes']['name']).to eq user.name
      expect(jdata['data']['links']['self']).to eq user_url(user, { host: "localhost", port: 3000 })
    end

    it "returns 404 with invalid id" do
      user = User.create! valid_attributes
      get :show, params: {id: 'z'}, session: valid_session
      expect(assigns(:user)).not_to eq(user)
      expect(response).to have_http_status(:not_found)
      expect(response.headers['Content-Type']).to match %r{application/vnd.api\+json}
      jdata = JSON.parse(response.body)
      expect(jdata['errors'][0]['detail']).to eq "Wrong ID provided"
      expect(jdata['errors'][0]['source']['pointer']).to eq '/data/attributes/id'
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_name){ "The User #1" }
      let(:new_attributes) {
        valid_attributes.merge(name: new_name)
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
        user.reload
        expect(user.name).to eq new_name
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: {id: user.to_param}, session: valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete :destroy, params: {id: user.to_param}, session: valid_session
      expect(response).to have_http_status(:no_content)
    end
  end

end
