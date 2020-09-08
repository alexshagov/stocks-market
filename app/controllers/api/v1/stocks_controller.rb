module Api
  module V1
    class StocksController < BaseController
      def index
        stocks = Stock.all

        render json: StocksRepresenter.for_collection.prepare(stocks).to_json
      end

      def create
        perform_create!(
          schema: Stocks::CreateSchema,
          action: Stocks::Create,
          representer: StocksRepresenter)
      end

      def update
        perform_update!(
          entity: Stock.find(params[:id]),
          schema: Stocks::UpdateSchema,
          action: Stocks::Update,
          representer: StocksRepresenter)
      end
    end
  end
end
