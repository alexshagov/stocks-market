module Stocks
  class Create
    attr_reader :validated_params

    def initialize(validated_params, dependencies: { create_bearer: Bearers::Create })
      @validated_params = validated_params
      @dependencies = dependencies
    end

    def self.call(validated_params)
      new(validated_params).call
    end

    def call
      ActiveRecord::Base.transaction do
        bearer = dependencies[:create_bearer].call(bearer_attributes)
        Stock.create!(stock_attributes.merge(bearer: bearer))
      end
    end

    private

    attr_reader :dependencies

    def bearer_attributes
      {
        name: validated_params[:bearer][:name],
      }
    end

    def stock_attributes
      {
        name: validated_params[:name],
        reference: SecureRandom.uuid
      }
    end
  end
end
