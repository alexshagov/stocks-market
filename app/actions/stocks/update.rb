module Stocks
  class Update
    attr_reader :validated_params, :stock

    def initialize(validated_params, stock,
      dependencies: { create_bearer: Bearers::Create })

      @validated_params = validated_params
      @stock = stock
      @dependencies = dependencies
    end

    def self.call(validated_params, stock)
      new(validated_params, stock).call
    end

    def call
      ActiveRecord::Base.transaction do
        assign_new_bearer!
        stock.assign_attributes(stock_attributes)

        stock.tap { |stock| stock.save! }
      end
    end

    private

    attr_reader :dependencies

    def assign_new_bearer!
      return unless bearer_attributes[:name].present?
      return if stock.bearer.name == bearer_attributes[:name]

      bearer =
        Bearer.find_by(name: bearer_attributes[:name]) || dependencies[:create_bearer].call(bearer_attributes)
      stock.bearer = bearer
    end

    def stock_attributes
      {
        name: validated_params[:name]
      }
    end

    def bearer_attributes
      {
        name: validated_params.dig(:bearer, :name)
      }
    end
  end
end
