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
        stock.assign_attributes(stock_attributes)

        stock.tap { |stock| stock.save! }
      end
    end

    private

    attr_reader :dependencies

    def new_bearer_id
      return if bearer_attributes[:name].blank?
      return if stock.bearer.name == bearer_attributes[:name]

      bearer =
        Bearer.find_by(name: bearer_attributes[:name]) || dependencies[:create_bearer].call(bearer_attributes)

      bearer.id
    end

    def stock_attributes
      {
        name: validated_params[:name],
        bearer_id: new_bearer_id || stock.bearer_id
      }
    end

    def bearer_attributes
      {
        name: validated_params.dig(:bearer, :name)
      }
    end
  end
end
