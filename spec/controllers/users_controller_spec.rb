require 'rails_helper'

describe UsersController do

  let(:user) { create(:user) }

  describe 'users #show' do

    before { user }

    it 'properly sets @user' do
      controller_sign_in(user)
      process :show, params: { id: user.id }
      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq(user)
    end

  end

  describe 'users#create' do

    it 'creates a new user with proper submission' do
      expect do
       process :create, params: { user: attributes_for(:user) }
      end
      .to change(User, :count).by(1)
    end

    it 'does not create a user with improper submission' do
      expect do
       process :create, params: { user: attributes_for(:user, :user_blank_name) }
      end
      .to change(User, :count).by(0)
      expect(response).to render_template(:new)
    end
  end

  describe 'users#edit' do
  end

  describe 'users#update' do
  end

  describe 'users#destroy' do
  end

end
