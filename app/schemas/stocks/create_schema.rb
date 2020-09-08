module Stocks
  class CreateSchema
    class << self
      def build(params)
        Dry::Schema.JSON do
          required(:name).filled(:string)
          required(:bearer).hash do
            required(:name).filled(:string)
          end
        end.call(params)
      end
    end
  end
end

