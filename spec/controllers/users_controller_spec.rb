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
       process :create, params: { user: attributes_for(:user, :blank_name) }
      end
      .to change(User, :count).by(0)
      expect(response).to render_template(:new)
    end
  end

  describe 'users#edit' do

    before { controller_sign_in(user) }

    it 'a user can get to their own edit page' do
      process :edit, params: { id: user.id }
      expect(response).to have_http_status(200)
      expect(assigns(:user)).to eq(user)
    end

    it 'a user cannot access another user\'s edit page' do
      another_user = create(:user)
      process :edit, params: { id: another_user.id }
      expect(response).to redirect_to root_path
    end

  end

  describe 'users#update' do

    before { controller_sign_in(user) }

    it 'allows user to update with valid information' do
      before_name = user.name
      process :update, params:
        { user: attributes_for(:user, :non_default_name), id: user.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_path(user))
      user.reload
      expect(user.name).to_not eq(before_name)
    end

    it 'does not allow user to update with invalid information' do
      before_name = user.name
      process :update, params:
        { user: attributes_for(:user, :blank_name), id: user.id }
      expect(response).to render_template(:edit)
      user.reload
      expect(user.name).to eq(before_name)
    end

    it 'does not allow a user to update another user\'s information' do
      another_user = create(:user)
      process :update, params: { id: another_user.id }
      expect(response).to redirect_to root_path
    end

  end

  describe 'users#destroy' do

    before { controller_sign_in(user) }

    it 'allows user to delete their own account' do
      expect do
       process :destroy, params: { id: user.id }
      end
      .to change(User, :count).by(-1)
      expect(response).to redirect_to users_url
    end

    it 'does not allow user to delete another account' do
      another_user = create(:user)
      expect do
       process :destroy, params: { id: another_user.id }
      end
      .to change(User, :count).by(0)
      expect(response).to redirect_to root_url
    end

  end

end
