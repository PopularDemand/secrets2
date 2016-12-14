require 'rails_helper'

describe SecretsController do

  let(:secret) { create(:secret) }

  describe 'secrets #show' do

    before { secret }

    it 'properly sets @secret' do
      # get secret_url(secret) # not working?
      process :show#, params: { id: secret.id }
      expect(secret.persisted?).to be true
      expect(assigns(:secret)).to eq(secret)
    end

  end

end

adl;fkjasdlkf