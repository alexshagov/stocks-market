module Api
  module V1
    class StocksController < BaseController
      def index
        stocks = Stock.includes(:bearer).limit(100)

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

      def destroy
        perform_destroy!(
          entity: Stock.find(params[:id]),
          action: Stocks::Destroy
        )
      end
    end
  end
end
