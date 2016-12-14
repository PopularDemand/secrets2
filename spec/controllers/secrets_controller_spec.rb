require 'rails_helper'

describe SecretsController do

  let(:secret) { create(:secret) }
  let(:author) { secret.author }
  before { controller_sign_in(author) }

  describe 'secrets #show' do

    before { secret }

    it 'properly sets @secret' do
      # get secret_url(secret) # not working?
      process :show, params: { id: secret.id }
      expect(secret.persisted?).to be true
      expect(assigns(:secret)).to eq(secret)
    end

  end

  describe 'secrets#edit' do

    it 'an author can get to a secret edit page' do
      process :edit, params: { id: secret.id }
      expect(response).to have_http_status(200)
      expect(assigns(:secret)).to eq(secret)
    end

  end

  describe 'secrets #update' do

    it 'an author can edit their own secret' do
      before_title = secret.title
      process :update, params: { id: secret.id, secret: attributes_for(:secret, :non_default_title) }
      expect(response).to redirect_to secret_path(secret)
      secret.reload
      expect(secret.title).to_not eq(before_title)
    end

    it 'an author cannot update another author\'s secret' do
      another_user = create(:user)
      another_secret = create(:secret, author: another_user)
      expect { process :update, params: { id: another_secret.id, secret: attributes_for(:secret, :non_default_title)} }.to raise_error
    end

  end

  describe 'secrets #destroy' do
  end



end