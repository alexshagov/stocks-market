module Stocks
  class Update
    attr_reader :validated_params, :stock

    def initialize(validated_params, stock)
      @validated_params = validated_params
      @stock = stock
    end

    def self.call(validated_params, stock)
      new(validated_params, stock).call
    end

    def call
      stock.tap { |stock| stock.update!(stock_attributes) }
    end

    private

    def stock_attributes
      {
        name: validated_params[:name]
      }
    end
  end
end
