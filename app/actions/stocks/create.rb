module Stocks
  class Create
    attr_reader :validated_params

    def initialize(validated_params)
      @validated_params = validated_params
    end

    def self.call(validated_params)
      new(validated_params).call
    end

    def call
      ActiveRecord::Base.transaction do
        bearer = Bearer.create!(bearer_attributes)
        Stock.create!(stock_attributes.merge(bearer: bearer))
      end
    end

    private

    def bearer_attributes
      {
        name: validated_params[:bearer][:name],
        reference: SecureRandom.uuid
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
