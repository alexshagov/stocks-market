module Api
  module V1
    class StocksController < BaseController
      def index
        stocks = Stock.all

        render json: StocksRepresenter.for_collection.prepare(stocks).to_json
      end

      def create
        create!(
          schema: Stocks::CreateSchema,
          action: Stocks::Create,
          representer: StocksRepresenter)
      end
    end
  end
end
