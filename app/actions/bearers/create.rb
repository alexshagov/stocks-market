module Bearers
  class Create
    attr_reader :validated_params

    def initialize(validated_params)
      @validated_params = validated_params
    end

    def self.call(validated_params)
      new(validated_params).call
    end

    def call
      Bearer.create!(bearer_attributes)
    end

    private

    def bearer_attributes
      {
        name: validated_params[:name],
        reference: SecureRandom.uuid
      }
    end
  end
end
