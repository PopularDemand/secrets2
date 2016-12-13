require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  it 'has the default attributes' do
    expect(user).to be_valid
  end

  it 'is invalid if name is not present' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is invalid if email is not present' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'can have secrets' do
    expect(user).to respond_to(:secrets)
  end

  it 'accepts a name of length between 3 and 20 chars' do
    expect(user).to be_valid
  end

  it 'is invalid if name length is less than 3 chars' do
    user.name = "Bo"
    expect(user).to_not be_valid
  end

  it 'is invalid if name length is greater than 20 chars' do
    user.name = "fjksdlfjsdkfjksdjfdsjafasdjfidsafidjsiafjadsifds"
    expect(user).to_not be_valid
  end

  it 'has a unique email' do
    expect(user).to be_valid
  end

  it 'is invalid if email is already taken' do
    user.save
    new_user = build(:user, email: user.email)
    expect(new_user).to_not be_valid
  end

  it 'accepts a password with length between 6 and 16 chars' do
    expect(user).to be_valid
  end

  it 'is invalid if password length is less than 6 chars' do
    user.password = "bar"
    expect(user).to_not be_valid
  end

  it 'is invalid if password length is greater than 16 chars' do
    user.password = "barbarbarbarbarbarbarbarbarbar"
    expect(user).to_not be_valid
  end

  # it 'allows nil' do
  #   user.save
  #   user.update(name: "George", email: "George@gmail.com")
  #   expect(user).to be_valid
  # end
  # come back to this one

end
