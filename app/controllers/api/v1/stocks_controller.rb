module Api
  module V1
    class StocksController < ApplicationController
      def index
        stocks = Stock.all

        render json: StocksRepresenter.for_collection.prepare(stocks).to_json
      end
    end
  end
end
