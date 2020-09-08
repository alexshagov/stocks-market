require 'rails_helper'

RSpec.describe '/api/v1/stocks', type: :request do

  describe 'GET /stocks' do
    before do
      bearer = create(:bearer)
      create(:stock, bearer: bearer)
    end

    it 'renders stocks' do
      get '/api/v1/stocks'
      expect(response).to match_json_schema('stocks')
    end
  end

end
