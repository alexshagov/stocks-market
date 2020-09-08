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
        expect(response.status).to eq 201
        expect(response).to match_json_schema('stock')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          name: nil
        }
      end
      let(:expected_error) do
        {
          name: ["must be a string"],
          bearer: ["is missing"]
        }.to_json
      end

      it 'fails with 422' do
        post '/api/v1/stocks', params: params
        expect(response.status).to be 422
      end
    end
  end

  describe 'PATCH /stocks/:id' do
    let(:bearer) { create(:bearer) }
    let(:stock) { create(:stock, bearer: bearer) }

    context 'with valid params' do
      let(:params) do
        {
          name: 'updated name'
        }
      end

      it 'updates a stock record' do
        patch "/api/v1/stocks/#{stock.id}", params: params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq params[:name]
        expect(response).to match_json_schema('stock')
      end

      context 'when bearer is changed to an existing one' do
        let(:another_bearer) { create(:bearer) }

        let(:params) do
          {
            name: 'updated name',
            bearer: { name: another_bearer.name }
          }
        end

        it 'updates a stock record and assigns it to a new bearer' do
          patch "/api/v1/stocks/#{stock.id}", params: params

          expect(response.status).to eq 200
          expect(response).to match_json_schema('stock')
          expect(stock.reload.bearer).to eq another_bearer
        end
      end

      context 'when new bearer name provided' do
        let(:params) do
          {
            name: 'updated name',
            bearer: { name: 'new bearer name' }
          }
        end

        it 'updates a stock record and creates a new bearer' do
          patch "/api/v1/stocks/#{stock.id}", params: params

          expect(response.status).to eq 200
          expect(response).to match_json_schema('stock')
          expect(stock.reload.bearer).to eq Bearer.find_by(name: params[:bearer][:name] )
        end
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          name: nil
        }
      end
      let(:expected_error) do
        {
          name: ["must be a string"]
        }.to_json
      end

      it 'fails with 422' do
        patch "/api/v1/stocks/#{stock.id}", params: params
        expect(response.status).to be 422
      end
    end
  end

  describe 'DELETE /stocks/:id' do
    let(:bearer) { create(:bearer) }
    let(:stock) { create(:stock, bearer: bearer) }

    it 'marks record as deleted' do
      delete "/api/v1/stocks/#{stock.id}"

      expect(response.status).to eq 204
      expect(stock.reload.deleted?).to eq true
    end
  end
end
