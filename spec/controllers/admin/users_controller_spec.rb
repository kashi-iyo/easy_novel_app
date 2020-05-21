require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  it 'get new' do
    get :new
    expect(response.status).to eq(200)
  end
end
