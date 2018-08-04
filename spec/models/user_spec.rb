require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates or updates itself from an oauth hash' do
    auth = {provider: 'google',
            uid: '0123456789',
            info: {
              email: 'erikaannesmith@gmail.com',
              first_name: 'Erika',
              last_name: 'Smith'
            },
            credentials: {
              token: '0123456789',
              refresh_token: '9876543210',
              expires_at: DateTime.now
            }}
    User.update_or_create(auth)
    new_user = User.first

    expect(new_user.provider).to eq('google')
    expect(new_user.uid).to eq('0123456789')
    expect(new_user.email).to eq('erikaannesmith@gmail.com')
    expect(new_user.first_name).to eq('Erika')
    expect(new_user.last_name).to eq('Smith')
    expect(new_user.token).to eq('0123456789')
    expect(new_user.refresh_token).to eq('9876543210')
    expect(new_user.oauth_expires_at).to eq(auth[:credentials][:expires_at])
  end
end
