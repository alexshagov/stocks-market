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

  describe 'POST /stocks' do
    context 'with valid params' do
      let(:params) do
        {
          name: '123',
          bearer: { name: 'bearer' }
        }
      end

      it 'creates a stock record' do
        post '/api/v1/stocks', params: params
        expect(response).to match_json_schema('stock')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          name: nil
        }
      end

      it 'creates a stock record' do
        post '/api/v1/stocks', params: params
      end
    end
  end

end
